import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';
import 'package:scflutter/components/LoadingNew.dart';
import 'package:scflutter/mixins/NewLoading.mixin.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/repositories/room.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../utils/palette.dart';
import '../Avatar.dart';

class JoinedCommunities extends ConsumerStatefulWidget {
  const JoinedCommunities({Key? key}) : super(key: key);

  @override
  JoinedCommunitiesState createState() => JoinedCommunitiesState();
}

class JoinedCommunitiesState extends ConsumerState<JoinedCommunities>
    with NewLoadingMixin<JoinedCommunities>, TickerProviderStateMixin {
  final RoomRepository _roomRepository = RoomRepository();
  late List<RoomPartipicationWithRoomData> rooms;
  //TODO: remove count, use .length instead
  int count = 0;

  @override
  void initState() {
    super.initState();

    fetchRooms();
  }

  fetchRooms() async {
    final userId = Supabase.instance.client.auth.user()!.id;

    final request = await _roomRepository.fetchJoinedRooms(userId: userId);

    final mappedData = List<RoomPartipicationWithRoomData>.from(
        request.data.map((_) => RoomPartipicationWithRoomData.fromJson(_)));

    setLoading(false);
    setState(() {
      rooms = mappedData;
      count = request.count ?? 0;
    });
  }

  Widget Community({required String title}) {
    return Container(
      decoration: BoxDecoration(
          gradient: ColorPalette.surfaceLinearGradient,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Loading(
              size: AvatarSize.large,
              type: LoadingType.avatar,
              child: Avatar(
                username: title,
                avatarSize: AvatarSize.large,
              ),
            ),
            Loading(
              type: LoadingType.singleLine,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (count < 1) {
      return nil;
    }

    return Column(
      children: [
        Text(
          "myCommunities".tr().toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.grey.shade400),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: 160,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                final community = rooms[index];

                return Community(title: community.room_data.name!);
              }),
              scrollDirection: Axis.horizontal,
              itemCount: count,
            ),
          ),
        )
      ],
    );
  }
}
