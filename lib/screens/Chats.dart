import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/mixins/Loading.mixin.dart';
import 'package:scflutter/models/message.model.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/repositories/chat.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/theme/toast.dart';
import 'package:scflutter/utils/palette.dart';

import '../components/Avatar.dart';
import '../components/Badge.dart';
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

    final data = await _chatRepository.fetchAllChatRooms(id: userId);

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

  Future<bool> confirmDeleting(DismissDirection direction, String title) async {
    final intlArgs = {"name": title};

    final dialog = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("sureToDelete").tr(namedArgs: intlArgs),
          actions: [
            TextButton(
                onPressed: () => context.router.pop(false),
                child: const Text("cancelBtnTxt").tr()),
            ElevatedButton(
                onPressed: () => context.router.pop(true),
                child: const Text("deleteBtnTxt").tr()),
          ],
        );
      },
    );

    if (dialog != null) {
      return dialog;
    }

    return false;
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
            Color textColor = Colors.grey;

            if (message.user != localUser?.id) {
              username = message.user_data!.username;
              user = message.user_data!;
            }

            if (message.receiver != localUser?.id) {
              username = message.receiver_data!.username;
              user = message.receiver_data!;
            }

            if (message.seen) {
              textColor = Colors.grey.shade600;
            }

            return Dismissible(
              confirmDismiss: (_) =>
                  confirmDeleting(_, message.room_data!.name ?? "noName"),
              background: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.centerRight,
                color: ColorPalette.red,
                child: const Icon(FeatherIcons.trash2),
              ),
              key: Key(message.id.toString()),
              onDismissed: (_) => deleteRoom(message.room),
              child: InkWell(
                onTap: () => _navigateToChat(user, message.room_data!),
                child: Row(
                  children: [
                    _renderBadge(message.seen),
                    Avatar(
                      avatarSize: AvatarSize.mediumish,
                      username: username,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: message.seen ? textColor : null),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Text(
                                  message.text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          color:
                                              message.seen ? textColor : null),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: messages.length),
    );
  }

  Widget _renderBadge(bool messageSeen) {
    if (!messageSeen) {
      return const Padding(
          padding: EdgeInsets.only(right: 10), child: Badge(child: Text("1")));
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: main(),
    );
  }
}
