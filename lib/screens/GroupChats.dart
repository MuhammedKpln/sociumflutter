import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/mixins/NewLoading.mixin.dart';
import 'package:scflutter/models/message.model.dart';
import 'package:scflutter/repositories/chat.repository.dart';

import '../components/ChatList.dart';
import '../models/room.dart';
import '../models/user.dart';
import '../services/websocket.events.dart';
import '../state/auth.state.dart';
import '../theme/toast.dart';
import '../utils/router.gr.dart';

class GroupChatsPage extends ConsumerStatefulWidget {
  const GroupChatsPage({Key? key}) : super(key: key);

  @override
  _GroupChatsPageState createState() => _GroupChatsPageState();
}

class _GroupChatsPageState extends ConsumerState<GroupChatsPage>
    with NewLoadingMixin, TickerProviderStateMixin {
  final ChatRepository _chatRepository = ChatRepository();
  final SocketService _socketService = SocketService();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    fetchChatRooms();
  }

  Future<void> fetchChatRooms() async {
    final userId = ref.read(userProvider).user?.id ?? "";
    final data = await _chatRepository.fetchCommunityChats(id: userId);

    setState(() {
      messages = _sortMessages(data);
    });
  }

  List<Message> _sortMessages(List<Message> data) {
    return data
      ..sort((a, b) {
        if (a.seen) {
          return 0;
        }

        if (b.seen) {
          return 0;
        }

        return 1;
      });
  }

  deleteRoom(int roomId) async {
    _chatRepository.deleteRoom(roomId: roomId).then((value) {
      setState(() {
        messages.removeWhere((element) => element.room == roomId);
      });
      context.toast.showToast("success".tr(), toastType: ToastType.Success);
    }).catchError(onError);
  }

  _navigateToChat(UserModel user, Room room) async {
    await context.router.navigate(GroupChatRoute(roomDetails: room));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await fetchChatRooms(),
      child: ListView.separated(
          itemBuilder: ((context, index) {
            final message = messages[index];

            return ChatList(
              deleteRoom: deleteRoom,
              navigateToChat: _navigateToChat,
              message: message,
              user: message.user_data!,
              title: message.room_data!.name!,
              groupChat: true,
            );
          }),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: messages.length),
    );
  }
}
