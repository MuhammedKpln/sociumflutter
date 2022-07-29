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
import 'package:scflutter/utils/avatar.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart' as rt;

class Chat extends ConsumerStatefulWidget {
  Chat(
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

class _ChatState extends ConsumerState<Chat> {
  List<types.Message> messages = [];
  bool connectedToCall = false;
  bool micMuted = false;
  bool mediaPermissionsAlllowed = false;
  bool audio = false;
  bool video = false;
  double floatinActionButtonScale = 1;

  late MediaStream? localStream;
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

  void initCallFeature() async {
    final webRtcService = await createPeerConnection(rtcConfig);
    peerConnection = PeerConnection(webRtcService);

    widget.socketService.onAnswerMade((data) async {
      print("answe r made");
      final answer =
          RTCSessionDescription(data.answer["sdp"], data.answer["type"]);

      await peerConnection.peerConnection.setRemoteDescription(answer);
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

      scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: Text(
              "Permissions given audio: ${response.audio}, video: ${response.video}")));
    });

    peerConnection.peerConnection.onConnectionState = (state) {
      if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
        setState(() {
          connectedToCall = true;
        });
      }
    };

    peerConnection.peerConnection.onIceCandidate = (candidate) {
      widget.socketService.addIceCandidate(candidate, widget.userUUID!);
    };

    widget.socketService.onIceCandidate((response) async {
      final candidate = RTCIceCandidate(response.candidate["candidate"],
          response.candidate["sdpMid"], response.candidate["sdpMLineIndex"]);

      await peerConnection.peerConnection.addCandidate(candidate);
    });
  }

  void answerCall(RTCSessionDescription offer, String uuid) async {
    print("answered");
    final stream = await peerConnection.getUserMedia();
    await peerConnection.addStream(stream);
    final answer = await peerConnection.createAnswer(offer);

    widget.socketService.makeAnswer(answer, uuid);
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

    widget.socketService.onCallMade((data) {
      print("call made");
      final offer =
          RTCSessionDescription(data.offer["sdp"], data.offer["type"]);

      context.router.navigate(rt.CallComing(
          username: widget.connectedUser!.username!,
          onAcceptCall: () => answerCall(offer, data.uuid),
          onRejectCall: () => context.router.pop()));
    });
  }

  disposeEvents() {
    if (localStream != null) {
      localStream?.dispose();
    }
    if (floatinActionButtonAnimatorTimer != null) {
      floatinActionButtonAnimatorTimer?.cancel();
    }

    peerConnection.peerConnection.close();
    widget.socketService.eventEmitter
        .removeAllByEvent(SocketListenerEvents.MESSAGE_RECEIVED.path);
    widget.socketService.eventEmitter
        .removeAllByEvent(SocketListenerEvents.ANSWER_MADE.path);
    widget.socketService.eventEmitter
        .removeAllByEvent(SocketListenerEvents.CALL_MADE.path);
    widget.socketService.eventEmitter
        .removeAllByEvent(SocketListenerEvents.RECEIVED_ICE_CANDIDATE.path);
    widget.socketService.eventEmitter
        .removeAllByEvent(SocketListenerEvents.MEDIA_PERMISSION_ANSWERED.path);
    widget.socketService.eventEmitter
        .removeAllByEvent(SocketListenerEvents.MEDIA_PERMISSION_ASKED.path);
  }

  @override
  void dispose() {
    super.dispose();

    disposeEvents();
  }

  void onSendMessage(types.PartialText text) {
    final provider = ref.read(userProvider.notifier);
    final localUser = provider.state.user;

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
    localStream = stream;
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

    return Scaffold(
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

    //FIXME: memory leak?
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
    return AnimatedScale(
      duration: const Duration(milliseconds: 500),
      scale: floatinActionButtonScale,
      child: FloatingActionButton(
          enableFeedback: true,
          onPressed: () => null,
          child: const Icon(FeatherIcons.phoneOutgoing)),
    );
  }

  Widget renderChat() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Avatar(
              avatarSize: AvatarSize.small,
              avatarName: widget.connectedUser?.username),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.connectedUser?.username ?? "",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ]),
        actions: [askForPermissionsButton(), mic()],
      ),
      floatingActionButton: connectedToCall ? renderFloatingButton() : null,
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
            id: widget.connectedUser?.id.toString() ?? "qwel",
            firstName: widget.connectedUser?.username ?? ""),
        messages: messages,
        groupMessagesThreshold: 1,
        emojiEnlargementBehavior: chatUi.EmojiEnlargementBehavior.multi,
        showUserAvatars: true,
      ),
    );
  }

  Widget askForPermissionsButton() {
    if (connectedToCall) return Container();

    return IconButton(
        onPressed: callOrAskForPermission,
        icon: Icon(!mediaPermissionsAlllowed
            ? FeatherIcons.phoneOff
            : FeatherIcons.phoneCall));
  }

  Widget mic() {
    if (!connectedToCall) {
      return Container();
    }

    return IconButton(
        onPressed: () {
          if (micMuted) {
            localStream?.getAudioTracks()[0].enabled = true;
          } else {
            localStream?.getAudioTracks()[0].enabled = false;
          }
        },
        icon: Icon(!micMuted ? FeatherIcons.micOff : FeatherIcons.mic));
  }
}
