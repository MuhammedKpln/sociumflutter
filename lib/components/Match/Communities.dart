import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/Match/JoinedCommunities.dart';
import 'package:scflutter/mixins/Loading.mixin.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/repositories/room.repository.dart';
import 'package:scflutter/theme/icon.dart';
import 'package:scflutter/utils/palette.dart';

class CommunitiesTab extends StatefulWidget {
  const CommunitiesTab({Key? key}) : super(key: key);

  @override
  State<CommunitiesTab> createState() => _CommunitiesTabState();
}

class _CommunitiesTabState extends State<CommunitiesTab> with LoadingMixin {
  final RoomRepository _roomRepository = RoomRepository();
  int count = 0;
  List<RoomWithPartipicationsData>? data;
  List<RoomPartipicationWithRoomData> joinedRooms = [];

  renderBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(),
        context: context,
        builder: ((context) {
          return DraggableScrollableSheet(
              expand: false,
              builder: ((context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: const [
                      Text(
                        "selam",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }));
        }));
  }

  @override
  void initState() {
    super.initState();

    _roomRepository.fetchPublishedRooms().then((value) {
      final mapped = List<RoomWithPartipicationsData>.from(
          value.data.map((_) => RoomWithPartipicationsData.fromJson(_)));

      setState(() {
        count = value.count!;
        data = mapped;
      });
    });
  }

  Widget Post({
    required String title,
    required int userCount,
  }) {
    return Stack(alignment: Alignment.centerLeft, children: [
      InkWell(
        onTap: renderBottomSheet,
        child: Container(
            margin: const EdgeInsets.only(left: 40),
            padding:
                const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 10),
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText("Topluluklar",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        Theme.of(context).textTheme.titleLarge?.fontSize)),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                "Yeni topluluklar keşfedin",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.grey.shade400),
              ),
            ),
            const JoinedCommunities(),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  final post = data![index];

                  return Post(
                      title: post.name!,
                      userCount: post.room_partipications_data.length);
                }),
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
                itemCount: count),
          ],
        ),
      ),
    );
  }
}
