import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chatUi;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/Loading.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/graphql/graphql_api.dart';
import 'package:scflutter/main.dart';
import 'package:scflutter/models/message.dart';
import 'package:scflutter/models/socket/send_message_arguments.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:scflutter/services/webrtc.service.dart';
import 'package:scflutter/services/websocket.events.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/theme/animation_durations.dart';
import 'package:scflutter/utils/avatar.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart';

import '../components/Scaffold.dart';

ValueNotifier<bool> chatMicMuted = ValueNotifier<bool>(false);
ValueNotifier<bool> chatCameraOpened = ValueNotifier<bool>(false);
ValueNotifier<MediaStream?> remoteStream = ValueNotifier(null);
ValueNotifier<MediaStream?> localStream = ValueNotifier(null);

class ChatScreenPage extends ConsumerStatefulWidget {
  ChatScreenPage(
      {Key? key,
      required this.comingFromMatchedPage,
      required this.socketService,
      this.connectedUser,
      this.room,
      this.userUUID})
      : super(key: key);

  bool comingFromMatchedPage = true;
  User? connectedUser;
  Room? room;
  String? userUUID;
  SocketService socketService;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

class _ChatState extends ConsumerState<ChatScreenPage> {
  List<types.Message> messages = [];
  ValueNotifier<bool> connectedToCall = ValueNotifier<bool>(false);
  bool mediaPermissionsAlllowed = false;
  bool audio = false;
  bool video = false;
  double floatinActionButtonScale = 1;

  late PeerConnection peerConnection;
  late Timer? floatinActionButtonAnimatorTimer;

  @override
  void initState() {
    super.initState();
    coreInit();

    if (widget.comingFromMatchedPage) {
      initCallFeature();
    }
  }

  onPressHangup() async {
    localStream.value?.getTracks().forEach((track) => track.stop());
    remoteStream.value?.getTracks().forEach((track) => track.stop());
    await peerConnection.events.close();
  }

  navigateToCallManager() {
    context.router.navigate(InCallManagerScreenRoute(
        username: widget.connectedUser?.username ?? "null",
        onPressHangup: onPressHangup));
  }

  void initCallFeature() async {
    chatMicMuted = ValueNotifier(false);
    chatCameraOpened = ValueNotifier(false);
    localStream = ValueNotifier(null);
    remoteStream = ValueNotifier(null);

    chatMicMuted.addListener(() {
      // FIXME: does not work when camera is opened?
      if (!chatMicMuted.value) {
        localStream.value
            ?.getAudioTracks()
            .forEach((track) => track.enabled = true);
      } else {
        localStream.value
            ?.getAudioTracks()
            .forEach((track) => track.enabled = false);
      }
    });

    chatCameraOpened.addListener(() async {
      if (chatCameraOpened.value) {
        final MediaStream stream =
            await peerConnection.getUserMedia(turnVideoOn: true);
        localStream.value = stream;
        final videoTrack = localStream.value?.getVideoTracks()[0];

        await localStream.value?.addTrack(videoTrack!);
        await peerConnection.events.addTrack(videoTrack!, localStream.value!);

        final offer = await peerConnection.createOffer();
        widget.socketService.callUser(offer, widget.userUUID!);
      }
    });

    connectedToCall.addListener(() {
      if (connectedToCall.value) {
        floatinActionButtonAnimatorTimer =
            Timer.periodic(const Duration(milliseconds: 700), (timer) {
          if (floatinActionButtonScale == 1) {
            setState(() {
              floatinActionButtonScale = 0.5;
            });
          } else {
            setState(() {
              floatinActionButtonScale = 1;
            });
          }
        });

        navigateToCallManager();
      }
    });

    final webRtcService = await createPeerConnection(rtcConfig);
    peerConnection = PeerConnection(webRtcService);

    widget.socketService.onAnswerMade((data) async {
      final answer =
          RTCSessionDescription(data.answer["sdp"], data.answer["type"]);

      await peerConnection.setRemoteDescription(answer);
    });

    widget.socketService.onMediaPermissionsAsked((response) {
      audio = response.audio != null ? response.audio! : audio;
      video = response.video != null ? response.video! : video;

      showModalBottomSheet(
          context: context,
          builder: (context) => handlePermissionsModal(context, setState,
              askingForPermission: false));
    });

    widget.socketService.onMediaPermissionAnswered((response) {
      if (audio || video) {
        setState(() {
          mediaPermissionsAlllowed = true;
        });
      }
    });

    peerConnection.events.onConnectionState = (state) {
      if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
        connectedToCall.value = true;
      }
      if (state == RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
        connectedToCall.value = false;
      }
    };

    peerConnection.events.onIceCandidate = (candidate) {
      widget.socketService.addIceCandidate(candidate, widget.userUUID!);
    };

    peerConnection.events.onAddStream = ((stream) {
      final videoTracksLength = stream.getVideoTracks().length;

      if (videoTracksLength > 0) {
        remoteStream.value = stream;
      }
    });

    widget.socketService.onIceCandidate((response) async {
      final candidate = RTCIceCandidate(response.candidate["candidate"],
          response.candidate["sdpMid"], response.candidate["sdpMLineIndex"]);

      await peerConnection.events.addCandidate(candidate);
    });
  }

  void answerCall(RTCSessionDescription offer, String uuid) async {
    final stream = await peerConnection.getUserMedia();

    await peerConnection.addStream(stream);

    final answer = await peerConnection.createAnswer(offer);

    widget.socketService.makeAnswer(answer, uuid);

    context.router.pop();
  }

  void coreInit() {
    widget.socketService.joinRoom(widget.room!.roomAdress);

    widget.socketService.onMessageReceived((response) {
      Message message = response.message;
      setState(() {
        messages.insert(
            0,
            types.TextMessage(
                id: message.id.toString(),
                author: types.User(
                    id: message.senderId.toString(),
                    imageUrl: generateAvatarUrl(message.sender.avatar!),
                    firstName: message.sender.username),
                text: message.message));
      });
    });

    widget.socketService.onCallMade((data) async {
      final offer =
          RTCSessionDescription(data.offer["sdp"], data.offer["type"]);

      if (connectedToCall.value) {
        await upgradeCall(offer);

        return;
      }

      context.router.navigate(CallComingRoute(
          username: widget.connectedUser!.username!,
          onAcceptCall: () => answerCall(offer, data.uuid),
          onRejectCall: () => context.router.pop()));
    });
  }

  Future<void> upgradeCall(RTCSessionDescription offer) async {
    final MediaStream stream =
        await peerConnection.getUserMedia(turnVideoOn: true);
    localStream.value = stream;

    final videoTrack = localStream.value?.getVideoTracks()[0];
    await localStream.value?.addTrack(videoTrack!);
    await peerConnection.events.addTrack(videoTrack!, localStream.value!);

    final answer = await peerConnection.createAnswer(offer);
    widget.socketService.makeAnswer(answer, widget.userUUID!);
  }

  disposeEvents() {
    try {
      localStream.dispose();
      if (floatinActionButtonAnimatorTimer != null) {
        floatinActionButtonAnimatorTimer?.cancel();
      }
    } catch (err) {}

    connectedToCall.dispose();
    chatMicMuted.dispose();
    chatCameraOpened.dispose();
    remoteStream.dispose();
    localStream.dispose();

    peerConnection.events.close();
    widget.socketService.socket.off(SocketListenerEvents.MESSAGE_RECEIVED.path);
    widget.socketService.socket.off(SocketListenerEvents.ANSWER_MADE.path);
    widget.socketService.socket.off(SocketListenerEvents.CALL_MADE.path);
    widget.socketService.socket
        .off(SocketListenerEvents.RECEIVED_ICE_CANDIDATE.path);
    widget.socketService.socket
        .off(SocketListenerEvents.MEDIA_PERMISSION_ANSWERED.path);
    widget.socketService.socket
        .off(SocketListenerEvents.MEDIA_PERMISSION_ASKED.path);
  }

  @override
  void dispose() {
    super.dispose();

    disposeEvents();
  }

  void onSendMessage(types.PartialText text) {
    final provider = ref.read(userProvider);
    final localUser = provider.user;

    widget.socketService.sendMessage(SendMessageArguments(
        room: widget.room!.roomAdress,
        message: text.text,
        user: localUser!,
        receiver: widget.connectedUser!));
  }

  void mergeChatFromQuery(Map<String, dynamic> results) {
    final data = FetchRoomMessage$Query.fromJson(results);
    final List<types.Message> mappedData = [];

    for (var message in data.messagesFromRoom) {
      mappedData.add(types.TextMessage(
          id: message.id.toString(),
          author: types.User(
              id: message.sender.id.toString(),
              imageUrl: generateAvatarUrl(message.sender.avatar!),
              firstName: message.sender.username),
          text: message.message));
    }

    setState(() {
      messages.addAll(mappedData);
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

    scaffoldKey.currentState
        ?.showSnackBar(const SnackBar(content: Text("Calling")));
  }

  void askForMediaPermissions() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: ((context, setState) => handlePermissionsModal(
                  context, setState,
                  askingForPermission: true)));
        });
  }

  void sendPermissionsAsked() {
    widget.socketService
        .askForMediaPermissions(widget.userUUID!, audio: audio, video: video);
  }

  void acceptPermissionsAsked({bool audio = false, bool video = false}) {
    widget.socketService
        .giveMediaPermission(widget.userUUID!, audio: audio, video: video);
  }

  Widget handlePermissionsModal(BuildContext context, Function setState,
      {bool askingForPermission = false}) {
    handleAudioOnpress() {
      if (!askingForPermission) {
        return null;
      }

      setState(() {
        audio = !audio;
      });
    }

    handleVideoOnpress() {
      if (!askingForPermission) {
        return null;
      }
      setState(() {
        if (!audio) {
          audio = true;
        }
        video = !video;
      });
    }

    handleActionButton() {
      if (askingForPermission) {
        if (!audio && !video) {
          // If no permissions given, close the modal
          context.router.pop();
        }

        if (audio || video) {
          // Give/send permission to the user
          // Send permission
          sendPermissionsAsked();
          context.router.pop();
          scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text(askingForPermission
                  ? 'İsteğiniz gönderildi!'
                  : 'İstek kabul edildi, arama butonu aktif.')));
        } else {
          // Give permission
        }
      } else {
        if (!audio && video) {
          setState(() {
            audio = true;
            video = true;
          });
        }

        setState(() {
          mediaPermissionsAlllowed = true;
        });

        acceptPermissionsAsked(audio: audio, video: video);
        context.router.pop();

        scaffoldKey.currentState
            ?.showSnackBar(const SnackBar(content: Text("Istek kabul edildi")));
      }
    }

    return AppScaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            !askingForPermission
                ? '${widget.connectedUser?.username} sizi aramak için izin istedi.'
                : 'İstek türü',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          RoundedButton(
              style: ButtonStyle(
                  backgroundColor: audio
                      ? MaterialStateProperty.all(Colors.greenAccent)
                      : MaterialStateProperty.all(Colors.grey)),
              onPressed: handleAudioOnpress,
              child: Text(!askingForPermission
                  ? "Sesli sohbete izin ver"
                  : "Sesli sohbet izini iste")),
          RoundedButton(
              style: ButtonStyle(
                  backgroundColor: video
                      ? MaterialStateProperty.all(Colors.indigoAccent)
                      : MaterialStateProperty.all(Colors.grey)),
              onPressed: handleVideoOnpress,
              child: Text(!askingForPermission
                  ? "Görüntülü sohbete izin ver"
                  : "Görüntülü sohbet izini iste")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RoundedButton(
                  onPressed: handleActionButton,
                  child: Text(!askingForPermission
                      ? "İsteği kabul et"
                      : 'İsteği yolla')),
              if (!askingForPermission)
                RoundedButton(
                    onPressed: () => context.router.pop(),
                    child: const Text("İsteği reddet."))
            ],
          )
        ],
      ),
    ));
  }

  void callOrAskForPermission() {
    if (mediaPermissionsAlllowed) {
      makeCall();
    } else {
      askForMediaPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.comingFromMatchedPage) {
      return renderChat();
    }

    final variables = FetchRoomMessageArguments(
        roomId: widget.room!.id, offset: 0, limit: 15);

    return Query(
        options: QueryOptions(
            onComplete: (data) => mergeChatFromQuery(data),
            document: FetchRoomMessageQuery(variables: variables).document,
            variables: variables.toJson()),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Loading();
          }

          return renderChat();
        });
  }

  Widget renderFloatingButton() {
    return AnimatedScale(
      duration: Duration(milliseconds: AnimationDurations.medium.duration),
      scale: floatinActionButtonScale,
      child: FloatingActionButton(
          enableFeedback: true,
          onPressed: navigateToCallManager,
          child: const Icon(FeatherIcons.phoneOutgoing)),
    );
  }

  Widget renderChat() {
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
        theme: const chatUi.DarkChatTheme(
            backgroundColor: ColorPalette.background,
            primaryColor: ColorPalette.primary,
            secondaryColor: ColorPalette.surface,
            inputBackgroundColor: ColorPalette.surface),
        user: types.User(
            id: localUser?.id.toString() ?? "qwel",
            firstName: widget.connectedUser?.username ?? ""),
        messages: messages,
        groupMessagesThreshold: 1,
        emojiEnlargementBehavior: chatUi.EmojiEnlargementBehavior.multi,
      ),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Avatar(
          avatarSize: AvatarSize.small,
          username: widget.connectedUser!.username!,
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

  Widget askForPermissionsButton() {
    if (!widget.comingFromMatchedPage) return Container();
    if (connectedToCall.value) return Container();

    return IconButton(
        onPressed: callOrAskForPermission,
        icon: Icon(!mediaPermissionsAlllowed
            ? FeatherIcons.phoneOff
            : FeatherIcons.phoneCall));
  }
}
