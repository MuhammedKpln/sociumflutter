import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/mixins/Loading.mixin.dart';
import 'package:scflutter/models/chat_rooms.dart';
import 'package:scflutter/repositories/chat.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/theme/toast.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/Avatar.dart';
import '../components/Loading.dart';
import '../components/Scaffold.dart';
import '../models/room.dart';
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
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  final ChatRepository _chatRepository = ChatRepository();
  num? currentIndex = 0;
  List<ChatRooms> messages = [];
  SocketService socketService = SocketService();

  @override
  void initState() {
    super.initState();

    fetchChatRooms();

    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page?.round();
      });
    });
  }

  fetchChatRooms() async {
    final userId = ref.read(userProvider).user?.id ?? "";

    final data = await _chatRepository.fetchAllChatRooms(id: userId);

    setState(() {
      messages = data;
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

            String username = "";
            late UserModel user;

            if (message.user_data.id != localUser?.id) {
              username = message.user_data.username;
              user = message.user_data;
            }

            if (message.receiver_data.id != localUser?.id) {
              username = message.receiver_data.username;
              user = message.user_data;
            }

            return Dismissible(
              confirmDismiss: (_) =>
                  confirmDeleting(_, message.room_data.name ?? "noName"),
              background: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.centerRight,
                color: ColorPalette.red,
                child: const Icon(FeatherIcons.trash2),
              ),
              key: Key(message.id.toString()),
              onDismissed: (_) => deleteRoom(message.room),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => context.router.navigate(ChatNew(
                      comingFromMatchedPage: false,
                      connectedUser: user,
                      room: Room.fromJson(message.room_data.toJson()),
                      socketService: socketService)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Avatar(
                            avatarSize: AvatarSize.mediumish,
                            username: username,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  username,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Avatar(
                                          username: username,
                                          avatarSize: AvatarSize.extraSmall),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          message.text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: messages.length),
    );
  }

  Widget pageTwo() {
    return const Text("Page2");
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: main(),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: FutureBuilder(
        future: Future.value(true),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => pageController.jumpToPage(0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 100,
                      decoration: BoxDecoration(
                          color:
                              currentIndex == 0 ? ColorPalette.primary : null,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(FeatherIcons.user,
                          color: ColorPalette.grey, size: 15),
                    ),
                  ),
                  InkWell(
                    onTap: () => pageController.jumpToPage(1),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              currentIndex == 1 ? ColorPalette.primary : null,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(FeatherIcons.users,
                          size: 15, color: ColorPalette.grey),
                    ),
                  )
                ],
              ),
            )
          ]);
        },
      ),
    );
  }
}
