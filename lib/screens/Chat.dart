import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chatUi;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/Loading.dart';
import 'package:scflutter/graphql/graphql_api.dart';
import 'package:scflutter/models/message.dart';
import 'package:scflutter/models/socket/send_message_arguments.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:scflutter/services/websocket.events.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/utils/avatar.dart';
import 'package:scflutter/utils/palette.dart';

class Chat extends ConsumerStatefulWidget {
  Chat(
      {Key? key,
      required this.comingFromMatchedPage,
      this.connectedUser,
      this.room})
      : super(key: key);

  bool comingFromMatchedPage = true;
  User? connectedUser;
  Room? room;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class _ChatState extends ConsumerState<Chat> {
  List<types.Message> messages = [];
  SocketService socket = SocketService();

  @override
  void initState() {
    super.initState();

    socket.joinRoom(widget.room!.roomAdress);

    socket.onMessageReceived((response) {
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
  }

  @override
  void dispose() {
    super.dispose();

    socket.eventEmitter
        .removeAllByEvent(SocketListenerEvents.MESSAGE_RECEIVED.path);
  }

  void onSendMessage(types.PartialText text) {
    final provider = ref.read(userProvider.notifier);
    final localUser = provider.state.user;

    socket.sendMessage(SendMessageArguments(
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

    if (mounted) {
      setState(() {
        messages.addAll(mappedData);
      });
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
          )
        ]),
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
            id: widget.connectedUser?.id.toString() ?? randomString(),
            firstName: widget.connectedUser?.username ?? ""),
        messages: messages,
        sendButtonVisibilityMode: chatUi.SendButtonVisibilityMode.always,
        groupMessagesThreshold: 1,
        emojiEnlargementBehavior: chatUi.EmojiEnlargementBehavior.multi,
        showUserAvatars: true,
      ),
    );
  }
}
