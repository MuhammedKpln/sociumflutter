import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/ChatList.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/mixins/Loading.mixin.dart';
import 'package:scflutter/models/message.model.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/repositories/chat.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/theme/toast.dart';

import '../components/Loading.dart';
import '../components/Scaffold.dart';
import '../models/user.dart';
import '../services/websocket.events.dart';
import '../utils/router.gr.dart';

class ChatsScreenPage extends ConsumerStatefulWidget {
  const ChatsScreenPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreenPage>
    with LoadingMixin {
  final ChatRepository _chatRepository = ChatRepository();
  num? currentIndex = 0;
  List<Message> messages = [];
  SocketService socketService = SocketService();

  @override
  void initState() {
    super.initState();

    fetchChatRooms();
  }

  fetchChatRooms() async {
    final userId = ref.read(userProvider).user?.id ?? "";

    final data = await _chatRepository.fetchPrivateChats(id: userId);

    messages = data;

    setState(() {
      messages = _sortMessages();

      isLoading = false;
    });
  }

  Widget noDataExists() {
    return const Center(
      child: Text("Herhangi bir sohbet bulunamadı."),
    );
  }

  deleteRoom(int roomId) async {
    _chatRepository.deleteRoom(roomId: roomId).then((value) {
      setState(() {
        messages.removeWhere((element) => element.room == roomId);
      });
      context.toast.showToast("success".tr(), toastType: ToastType.Success);
    }).catchError(onError);
  }

  List<Message> _sortMessages() {
    return messages
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

  _navigateToChat(UserModel user, Room room) async {
    await context.router.navigate(ChatNew(
        comingFromMatchedPage: false,
        connectedUser: user,
        room: room,
        socketService: socketService));
  }

  Widget main() {
    if (isLoading) {
      return const Loading();
    }

    if (messages.isEmpty) {
      return noDataExists();
    }

    final localUser = ref.read(userProvider).user;

    return RefreshIndicator(
      onRefresh: () async => await fetchChatRooms(),
      child: ListView.separated(
          itemBuilder: ((context, index) {
            final message = messages[index];

            String username = "noName";
            late UserModel user;

            if (message.user != localUser?.id) {
              username = message.user_data!.username;
              user = message.user_data!;
            }

            if (message.receiver != localUser?.id) {
              username = message.receiver_data!.username;
              user = message.receiver_data!;
            }

            return ChatList(
                deleteRoom: deleteRoom,
                navigateToChat: _navigateToChat,
                message: message,
                user: user,
                title: username);
          }),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: messages.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: main(),
    );
  }
}
