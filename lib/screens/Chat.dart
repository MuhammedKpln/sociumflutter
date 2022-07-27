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
  late MediaStream localStream;
  late PeerConnection peerConnection;

  @override
  void initState() {
    print(widget.userUUID);
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

      context.router.navigate(const rt.CallComing());

      scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: const Text("Got call"),
        action: SnackBarAction(
          label: "Kabul et",
          onPressed: () => answerCall(offer, data.uuid),
        ),
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();

    localStream.dispose();
    peerConnection.peerConnection.close();
    widget.socketService.eventEmitter
        .removeAllByEvent(SocketListenerEvents.MESSAGE_RECEIVED.path);
    widget.socketService.eventEmitter
        .removeAllByEvent(SocketListenerEvents.ANSWER_MADE.path);
    widget.socketService.eventEmitter
        .removeAllByEvent(SocketListenerEvents.CALL_MADE.path);
    widget.socketService.eventEmitter
        .removeAllByEvent(SocketListenerEvents.RECEIVED_ICE_CANDIDATE.path);
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
        actions: [
          IconButton(
              onPressed: () => makeCall(),
              icon: const Icon(FeatherIcons.phoneCall)),
          if (connectedToCall)
            IconButton(
                onPressed: () {
                  if (micMuted) {
                    localStream.getAudioTracks()[0].enabled = true;
                  } else {
                    localStream.getAudioTracks()[0].enabled = false;
                  }
                },
                icon: Icon(!micMuted ? FeatherIcons.micOff : FeatherIcons.mic))
        ],
      ),
      body: chatUi.Chat(
        l10n: const chatUi.ChatL10nTr(),
        onMessageTap: (context, message) => print("selam"),
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
}
