import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/models/message.model.dart';
import 'package:scflutter/models/socket/media_permissions_response.dart';
import 'package:scflutter/repositories/chat.repository.dart';
import 'package:scflutter/screens/Chat/PeerConnection.mixin.dart';
import 'package:scflutter/screens/Chat/PermissionModal.dart';
import 'package:scflutter/theme/animation_durations.dart';
import 'package:scflutter/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../components/Avatar.dart';
import '../components/Scaffold.dart';
import '../models/room.dart';
import '../models/user.dart';
import '../services/websocket.events.dart';
import '../state/auth.state.dart';
import '../utils/avatar.dart';
import 'Chat/CallConnectInformation.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chatUi;

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
    with PeerConnectionMixin, TickerProviderStateMixin {
  final ChatRepository _chatRepository = ChatRepository();
  List<types.Message> messages = [];
  late RealtimeSubscription _stream;

  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: AnimationDurations.veryHigh.duration),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();

    peerConnectionEnsureInitialized(
        socketService: widget.socketService,
        userUUID: widget.connectedUser!.id,
        onClientDisconnected: _handleOnClientDisconnected,
        mediaPermissionsAnswered: _handleMediaPermissionsAllowedEvent,
        permissionsAskedCallback: _handlePermissionAskedEvent);

    fetchChatMessages().then((_) {
      listenMessages();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _stream.unsubscribe();
    disposeEvents(widget.socketService);
    super.dispose();
  }

  _handlePermissionAskedEvent() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return renderPermissionModal(askingForPermission: false);
        });
  }

  _handleMediaPermissionsAllowedEvent(MediaPermission payload) {
    print("selam");
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
    messagesStream.subscribe();

    _stream = messagesStream;
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
              imageUrl: generateAvatarUrl(message.user_data.avatar ?? ""),
              firstName: message.user_data.username),
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
            imageUrl: generateAvatarUrl(message.user_data.avatar ?? ""),
            firstName: message.user_data.username),
        text: message.text);
  }

  navigateToCallManager() {
    //FIXME: hopp
    // context.router.navigate(InCallManagerScreenRoute(
    //     username: widget.connectedUser?.username ?? "null",
    //     onPressHangup: onPressHangup));
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

  PreferredSizeWidget? renderAppBarBottom() {
    if (peerConnectionInitialized) {
      return PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CallConnectInformation(
            peerConnection: peerConnection,
          ));
    }
    return null;
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
        print(
          "Selam",
        );
        widget.socketService.askForMediaPermissions(widget.userUUID!,
            audio: audio, video: video);
      },
      acceptPermissionsAskedCallback: ({mediaPermissionsAllowed = false}) {
        print("Selam");

        setState(() {
          mediaPermissionsAlllowed = mediaPermissionsAllowed;
        });

        acceptPermissionsAsked(audio: audio, video: video);
        context.router.pop();
        context.toast.showToast("text");
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
    //TODO: when not allowed error, cancel it and navigate use§§r to the privacy settings
    final MediaStream stream = await peerConnection.getUserMedia();

    await peerConnection.addStream(stream);
    localStream.value = stream;
    final RTCSessionDescription offer = await peerConnection.createOffer();

    if (widget.userUUID != null) {
      widget.socketService.callUser(offer, widget.userUUID!);
    }
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

  AppBar renderAppBar() {
    return AppBar(
      bottom: renderAppBarBottom(),
      centerTitle: true,
      title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
        ),
      ]),
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

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(userProvider);
    final localUser = provider.user;

    return AppScaffold(
        appBar: renderAppBar(),
        floatingActionButton:
            connectedToCall.value ? renderFloatingButton() : null,
        body: chatUi.Chat(
          l10n: const chatUi.ChatL10nTr(),
          showUserNames: true,
          onSendPressed: onSendMessage,
          theme: SociumChatTheme,
          user: types.User(
              id: localUser?.id ?? "qwel",
              firstName: widget.connectedUser?.username ?? ""),
          messages: messages,
          groupMessagesThreshold: 1,
          emojiEnlargementBehavior: chatUi.EmojiEnlargementBehavior.multi,
        ));
  }
}
