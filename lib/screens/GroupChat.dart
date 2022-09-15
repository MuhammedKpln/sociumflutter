import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chatTypes;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/LoadingNew.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/extensions/theme.extension.dart';
import 'package:scflutter/mixins/NewLoading.mixin.dart';
import 'package:scflutter/models/message.model.dart';
import 'package:scflutter/repositories/chat.repository.dart';
import 'package:scflutter/utils/router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/Chat.dart';
import '../models/room.dart';
import '../state/auth.state.dart';
import '../utils/avatar.dart';

class GroupChatPage extends ConsumerStatefulWidget {
  GroupChatPage({super.key, required this.roomDetails});

  Room roomDetails;

  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends ConsumerState<GroupChatPage>
    with NewLoadingMixin, TickerProviderStateMixin {
  List<chatTypes.Message> messages = [];
  bool streamInitialized = false;
  late RealtimeSubscription _stream;
  final ChatRepository _chatRepository = ChatRepository();

  @override
  void initState() {
    super.initState();
    listenMessages();
    checkForRealtimeConnection();
    fetchChatMessages();
  }

  @override
  void dispose() {
    _stream.unsubscribe();
    super.dispose();
  }

  Future<void> fetchChatMessages() async {
    final remoteMessagesQuery =
        await _chatRepository.fetchChatMessages(roomId: widget.roomDetails.id);

    final parsedMessages = _mergeChatFromQuery(remoteMessagesQuery);

    setState(() {
      messages.addAll(parsedMessages);
    });
  }

  checkForRealtimeConnection() {
    _stream.on("system", (payload, {ref}) {
      if (payload["status"] == "ok") {
        setLoading(false);
        setState(() {
          streamInitialized = true;
        });
      }
    });
  }

  chatTypes.Message _convertToChatUIMessageObject(Map<String, dynamic> data) {
    final user = ref.read(userProvider).user;
    final userId = user?.id;

    final message = Message.fromJson({
      ...data,
      "user_data": user?.toJson(),
    });

    return chatTypes.TextMessage(
        id: message.id.toString(),
        author: chatTypes.User(
            id: message.user,
            imageUrl: generateAvatarUrl(message.user_data?.avatar ?? ""),
            firstName: message.user_data?.username),
        text: message.text);
  }

  listenMessages() async {
    final messagesStream =
        _chatRepository.listenMessages(widget.roomDetails.id, (payload) {
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

  List<chatTypes.Message> _mergeChatFromQuery(List<Message> results) {
    final List<chatTypes.Message> mappedData = [];

    for (var message in results) {
      mappedData.add(chatTypes.TextMessage(
          id: message.id.toString(),
          author: chatTypes.User(
              id: message.user,
              imageUrl: generateAvatarUrl(message.user_data?.avatar ?? ""),
              firstName: message.user_data?.username),
          text: message.text));
    }

    return mappedData;
  }

  Widget _renderUserAvatar(String username) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircleAvatar(
        child: Text(
          username[0],
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }

  _navigateToRoomDetails() async {
    final roomId = widget.roomDetails.id;
    await context.router.navigate(RoomDetailsRoute(roomId: roomId));
  }

  _renderAppBar() {
    final roomPartipications =
        widget.roomDetails.room_partipications_data?.take(2).toList();

    final roomPartipicationsAsWidget = roomPartipications?.map((e) {
      final index = roomPartipications.indexOf(e);

      if (index == 0) {
        return _renderUserAvatar(e.user_data?.username ?? "NoUsername");
      }

      return Positioned(
          left: 10,
          child: _renderUserAvatar(e.user_data?.username ?? "NoUsername"));
    }).toList();

    return AppBar(
      title: Loading(
        type: LoadingType.singleLine,
        child: InkWell(
          onTap: _navigateToRoomDetails,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.roomDetails.name ?? "No name",
                style: context.textStyles.titleSmall,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.passthrough,
                    children: roomPartipicationsAsWidget ?? []),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSendMessage(chatTypes.PartialText text) async {
    final provider = ref.read(userProvider);
    final localUser = provider.user;

    final model = SendMessage(
        text: text.text,
        seen: false,
        user: localUser!.id,
        group_message: true,
        room: widget.roomDetails.id);

    await _chatRepository.sendMessage(model);
  }

  void _handlePreviewDataFetched(
    int index,
    chatTypes.Message updatedMessage,
  ) {
    setState(() {
      messages[index] = updatedMessage;
    });
  }

  void onDeleteMessage(chatTypes.Message message) {
    setState(() {
      messages.removeWhere((element) => element.id == message.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(userProvider);
    final localUser = provider.user;

    return AppScaffold(
        appBar: _renderAppBar(),
        body: Chat(
          user: chatTypes.User(
              id: localUser?.id ?? "qwel",
              firstName: localUser?.username ?? ""),
          onPressSend: onSendMessage,
          messages: messages,
          showAvatar: true,
          showUsername: true,
          isLoading: streamInitialized,
          handlePreviewDataUpdateState: _handlePreviewDataFetched,
          onDeleteMessage: onDeleteMessage,
        ));
  }
}
