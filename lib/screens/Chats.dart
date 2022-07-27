import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/Loading.dart';
import 'package:scflutter/graphql/graphql_api.dart';
import 'package:scflutter/models/message.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:scflutter/services/websocket.events.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  num? currentIndex = 0;

  SocketService socketService = SocketService();

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page?.round();
      });
    });
  }

  Widget noDataExists() {
    return const Center(
      child: Text("Herhangi bir sohbet bulunamadı."),
    );
  }

  Widget pageOne() {
    return Query(
        options: QueryOptions(document: FetchMessagesQuery().document),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Loading();
          }
          final messages = result.data?["messages"] as List;
          if (messages.isEmpty) {
            return noDataExists();
          }

          final data = FetchMessages$Query.fromJson(result.data!);
          final localUser = ref.read(userProvider).user;

          return RefreshIndicator(
            onRefresh: () async => refetch!(),
            child: ListView.separated(
                itemBuilder: ((context, index) {
                  final FetchMessages$Query$Messages message =
                      data.messages[index];

                  String username = "";
                  User user = User.fromJson(message.sender.toJson());

                  if (message.sender.id != localUser?.id) {
                    username = message.sender.username;
                    user = User.fromJson(message.sender.toJson());
                  }

                  if (message.receiver.id != localUser?.id) {
                    username = message.receiver.username;
                    user = User.fromJson(message.receiver.toJson());
                  }

                  return InkWell(
                    onTap: () => AutoRouter.of(context).navigate(Chat(
                        comingFromMatchedPage: false,
                        connectedUser: user,
                        room: Room.fromJson(message.room.toJson()),
                        socketService: socketService)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Avatar(avatarSize: AvatarSize.mediumish),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                            avatarSize: AvatarSize.extraSmall),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            message.message,
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
                  );
                }),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: data.messages.length),
          );
        });
  }

  Widget pageTwo() {
    return const Text("Page2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [pageOne(), pageTwo()]),
    );
  }
}
