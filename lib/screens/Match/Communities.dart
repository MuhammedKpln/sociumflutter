import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/LoadingNew.dart';
import 'package:scflutter/components/Match/JoinedCommunities.dart';
import 'package:scflutter/mixins/NewLoading.mixin.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/repositories/room.repository.dart';
import 'package:scflutter/theme/icon.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart';

class CommunitiesTabPage extends ConsumerStatefulWidget {
  const CommunitiesTabPage({Key? key}) : super(key: key);

  @override
  _CommunitiesTabState createState() => _CommunitiesTabState();
}

class _CommunitiesTabState extends ConsumerState<CommunitiesTabPage>
    with NewLoadingMixin<CommunitiesTabPage>, TickerProviderStateMixin {
  final RoomRepository _roomRepository = RoomRepository();
  int count = 0;
  List<RoomWithPartipicationsData>? data;
  GlobalKey<JoinedCommunitiesState> testkey = GlobalKey();

  navigateToRoomDetails({required int roomId}) async {
    await context.router.root.push(RoomDetailsRoute(
        roomId: roomId,
        onPop: () {
          testkey.currentState!.fetchRooms();
          print("sen");
        }));
  }

  @override
  void initState() {
    super.initState();

    fetchPublishedRooms();
  }

  fetchPublishedRooms() async {
    _roomRepository.fetchPublishedRooms().then((value) {
      final mapped = List<RoomWithPartipicationsData>.from(
          value.data.map((_) => RoomWithPartipicationsData.fromJson(_)));

      setLoading(false);
      setState(() {
        count = value.count!;
        data = mapped;
      });
    });
  }

  Widget Post({
    required String title,
    required int userCount,
    required int roomId,
  }) {
    return Stack(alignment: Alignment.centerLeft, children: [
      InkWell(
        onTap: () => navigateToRoomDetails(roomId: roomId),
        child: Container(
            margin: const EdgeInsets.only(left: 40),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: ColorPalette.surfaceLinearGradient,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Icon(
                      FeatherIcons.globe,
                      size: IconSizes.medium.size,
                      color: Colors.grey,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            userCount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Icon(
                          FeatherIcons.users,
                          size: IconSizes.medium.size,
                          color: Colors.grey,
                        )
                      ],
                    )
                  ],
                )
              ],
            )),
      ),
      Avatar(
        username: title,
        avatarSize: AvatarSize.medium,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GradientText("communities".tr(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        Theme.of(context).textTheme.titleLarge?.fontSize)),
          ),
          Loading(
            type: LoadingType.list,
            child: JoinedCommunities(
              key: testkey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "exploreCommunities".tr().toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.grey.shade400),
            ),
          ),
          Loading(
              type: LoadingType.list,
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    final post = data![index];

                    return Post(
                        roomId: post.id,
                        title: post.name!,
                        userCount: post.room_partipications_data.length);
                  }),
                  separatorBuilder: ((context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  }),
                  itemCount: count))
        ],
      ),
    );
  }
}
