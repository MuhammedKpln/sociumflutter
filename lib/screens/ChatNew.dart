import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:peerdart/peerdart.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/models/message.model.dart';
import 'package:scflutter/models/socket/media_permissions_response.dart';
import 'package:scflutter/repositories/chat.repository.dart';
import 'package:scflutter/screens/Chat/PermissionModal.dart';
import 'package:scflutter/theme/animation_durations.dart';
import 'package:scflutter/utils/router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../components/Avatar.dart';
import '../components/Chat.dart';
import '../components/Scaffold.dart';
import '../models/room.dart';
import '../models/user.dart';
import '../services/websocket.events.dart';
import '../state/auth.state.dart';
import '../state/chat.state.dart';
import '../utils/avatar.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

part 'Chat/Chat.part.dart';

class ChatNew extends ConsumerStatefulWidget {
  ChatNew(
      {Key? key,
      required this.comingFromMatchedPage,
      required this.socketService,
      this.connectedUser,
      this.room,
      this.userUUID})
      : super(key: key);

  bool comingFromMatchedPage = true;
  UserModel? connectedUser;
  Room? room;
  String? userUUID;
  SocketService socketService;

  @override
  _ChatNewState createState() => _ChatNewState();
}

class _ChatNewState extends ConsumerState<ChatNew>
    with TickerProviderStateMixin {
  final ChatRepository _chatRepository = ChatRepository();
  List<types.Message> messages = [];
  bool streamInitialized = false;
  late RealtimeSubscription _stream;
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final Peer peer;
  late MediaStream localStream;
  late MediaStream remoteStream;
  late MediaConnection call;

  @override
  void initState() {
    super.initState();
    _initPeer();
    _initCallAnimation();

    if (widget.comingFromMatchedPage) {
      peerConnectionEnsureInitialized(
        socketService: widget.socketService,
        userUUID: widget.connectedUser!.id,
        onClientDisconnected: _handleOnClientDisconnected,
        mediaPermissionsAnswered: _handleMediaPermissionsAllowedEvent,
        permissionsAskedCallback: _handlePermissionAskedEvent,
      );

      _connectedToCallListener();
    }

    listenMessages();
    checkForRealtimeConnection();
    fetchChatMessages();
  }

  void _initCallAnimation() {
    _controller = AnimationController(
      duration: Duration(milliseconds: AnimationDurations.veryHigh.duration),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _connectedToCallListener() {
    connectedToCall.addListener(() {
      if (connectedToCall.value) {
        navigateToCallManager();
        return;
      }

      if (context.router.isRouteActive(InCallManagerScreenRoute.name)) {
        context.router.pop();
      }
    });
  }

  _initPeer() {
    final userId = ref.read(userProvider).user!.id;
    peer = Peer(id: userId);

    peer.on("call", null, (ev, _) async {
      call = ev.eventData as MediaConnection;

      call.on("stream", null, (ev, _) async {
        remoteStream = ev.eventData as MediaStream;
        connectedToCall.value = true;
      });

      context.router.navigate(CallComingRoute(
          username: widget.connectedUser!.username,
          onAcceptCall: () async {
            final mediaStream = await _getUserMedia(turnVideoOn: true);
            localStream = mediaStream;

            call.answer(mediaStream);
          }));
    });
  }

  Future<MediaStream> _getUserMedia({bool turnVideoOn = true}) async {
    const videoCons = {"facingMode": "user"};

    return await navigator.mediaDevices.getUserMedia(
        {"audio": true, "video": turnVideoOn ? videoCons : false});
  }

  checkForRealtimeConnection() {
    if (!streamInitialized) {
      _stream.on("system", (payload, {ref}) {
        if (payload["status"] == "ok") {
          setState(() {
            streamInitialized = true;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    peer.dispose();

    disposeEvents(widget.socketService);
    _controller.dispose();
    _stream.unsubscribe();
    super.dispose();
  }

  navigateToCallManager() {
    context.router.navigate(InCallManagerScreenRoute(
        username: widget.connectedUser?.username ?? "null",
        userAvatar: widget.connectedUser?.avatar ?? "null",
        onPressHangup: onPressHangup,
        localStream: localStream,
        remoteStream: remoteStream));
  }

  onPressHangup() async {
    call.close();

    connectedToCall.value = false;
  }

  _handlePermissionAskedEvent() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return renderPermissionModal(askingForPermission: false);
        });
  }

  _handleMediaPermissionsAllowedEvent(MediaPermission payload) {
    setState(() {
      audio = payload.audio!;
      video = payload.video!;
      mediaPermissionsAlllowed = true;
    });
  }

  _handleOnClientDisconnected() async {
    context.toast.showToast("Kullanıcı çıkış yaptı");
    await context.router.pop();
  }

  listenMessages() async {
    final messagesStream =
        _chatRepository.listenMessages(widget.room?.id ?? 0, (payload) {
      if (payload.eventType == "INSERT") {
        final message = _convertToChatUIMessageObject(payload.newRecord!);

        setState(() {
          messages.insert(0, message);
        });
      }
    });
    _stream = messagesStream;

    _stream.subscribe();
  }

  Future<void> fetchChatMessages() async {
    final remoteMessagesQuery =
        await _chatRepository.fetchChatMessages(roomId: widget.room?.id ?? 0);

    final parsedMessages = _mergeChatFromQuery(remoteMessagesQuery);

    setState(() {
      messages.addAll(parsedMessages);
    });
  }

  List<types.Message> _mergeChatFromQuery(List<Message> results) {
    final List<types.Message> mappedData = [];

    for (var message in results) {
      mappedData.add(types.TextMessage(
          id: message.id.toString(),
          author: types.User(
              id: message.user,
              imageUrl: generateAvatarUrl(message.user_data?.avatar ?? ""),
              firstName: message.user_data?.username),
          text: message.text));
    }

    return mappedData;
  }

  types.Message _convertToChatUIMessageObject(Map<String, dynamic> data) {
    final user = ref.read(userProvider).user;
    final userId = user?.id;

    final message = Message.fromJson({
      ...data,
      "user_data": user?.toJson(),
      "receiver_data": widget.connectedUser?.toJson(),
      "room_data": widget.room?.toJson()
    });

    return types.TextMessage(
        id: message.id.toString(),
        author: types.User(
            id: message.user,
            imageUrl: generateAvatarUrl(message.user_data?.avatar ?? ""),
            firstName: message.user_data?.username),
        text: message.text);
  }

  Widget renderFloatingButton() {
    return ScaleTransition(
      scale: _animation,
      child: FloatingActionButton(
          enableFeedback: true,
          onPressed: navigateToCallManager,
          child: const Icon(FeatherIcons.phoneOutgoing)),
    );
  }

  void acceptPermissionsAsked({bool audio = false, bool video = false}) {
    widget.socketService
        .giveMediaPermission(widget.userUUID!, audio: audio, video: video);
  }

  Widget renderPermissionModal({required bool askingForPermission}) {
    return PermissionModal(
      askingForPermission: askingForPermission,
      user: widget.connectedUser!,
      sendPermissionsAskedCallback: ({audio = false, video = false}) {
        widget.socketService.askForMediaPermissions(widget.userUUID!,
            audio: audio, video: video);
      },
      acceptPermissionsAskedCallback: ({mediaPermissionsAllowed = false}) {
        setState(() {
          mediaPermissionsAlllowed = mediaPermissionsAllowed;
        });

        acceptPermissionsAsked(audio: audio, video: video);
        context.router.pop();
      },
      audio: audio,
      video: video,
    );
  }

  void askForMediaPermissions() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return renderPermissionModal(askingForPermission: true);
        });
  }

  makeCall() async {
    final MediaStream mediaStream = await _getUserMedia(turnVideoOn: video);
    localStream = mediaStream;

    call = peer.call(widget.connectedUser!.id, mediaStream);

    _initLocalPeerEvents(call);
  }

  _initLocalPeerEvents(MediaConnection connection) {
    connection.on("stream", null, (ev, _) {
      final data = ev.eventData as MediaStream;
      remoteStream = data;
      connectedToCall.value = true;
    });
  }

  void callOrAskForPermission() {
    if (mediaPermissionsAlllowed) {
      makeCall();
    } else {
      askForMediaPermissions();
    }
  }

  Widget askForPermissionsButton() {
    if (!widget.comingFromMatchedPage) return Container();
    if (connectedToCall.value) return Container();

    return IconButton(
        onPressed: callOrAskForPermission,
        icon: Icon(!mediaPermissionsAlllowed
            ? FeatherIcons.phoneOff
            : FeatherIcons.phoneCall));
  }

  Future<void> navigateToUserProfile() async {
    await context.router.navigate(ProfilePageAsDialogRoute(
        username: widget.connectedUser?.username ?? "admin"));
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: InkWell(
        onTap: navigateToUserProfile,
        child: Row(children: [
          Avatar(
            avatarSize: AvatarSize.small,
            username: widget.connectedUser!.username,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.connectedUser?.username ?? "",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ]),
      ),
      actions: [
        askForPermissionsButton(),
      ],
    );
  }

  void onSendMessage(types.PartialText text) async {
    final provider = ref.read(userProvider);
    final localUser = provider.user;

    final model = SendMessage(
        text: text.text,
        seen: false,
        user: localUser!.id,
        receiver: widget.connectedUser!.id,
        room: widget.room!.id);

    await _chatRepository.sendMessage(model);
  }

  handlePreviewDataUpdateState(index, updatedMessage) {
    setState(() {
      messages[index] = updatedMessage;
    });
  }

  onDeleteMessage(types.Message message) {
    setState(() {
      messages.removeWhere((element) => element.id == message.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(userProvider);
    final localUser = provider.user;

    return AppScaffold(
        appBar: renderAppBar(),
        floatingActionButton:
            connectedToCall.value ? renderFloatingButton() : null,
        body: Chat(
          isLoading: streamInitialized,
          handlePreviewDataUpdateState: handlePreviewDataUpdateState,
          showUsername: true,
          onPressSend: onSendMessage,
          user: types.User(
              id: localUser?.id ?? "qwel",
              firstName: widget.connectedUser?.username ?? ""),
          messages: messages,
          onDeleteMessage: onDeleteMessage,
        ));
  }
}
