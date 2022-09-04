import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/mixins/Loading.mixin.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/repositories/room.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../utils/palette.dart';
import '../Avatar.dart';

class JoinedCommunities extends StatefulWidget {
  const JoinedCommunities({Key? key}) : super(key: key);

  @override
  State<JoinedCommunities> createState() => _JoinedCommunitiesState();
}

class _JoinedCommunitiesState extends State<JoinedCommunities>
    with LoadingMixin {
  final RoomRepository _roomRepository = RoomRepository();
  late List<RoomPartipicationWithRoomData> rooms;
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

    setState(() {
      rooms = mappedData;
      count = request.count ?? 0;
      isLoading = false;
    });
  }

  Widget Community({required String title}) {
    return Container(
      decoration: BoxDecoration(
          gradient: ColorPalette.surfaceLinearGradient,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Avatar(
              username: title,
              avatarSize: AvatarSize.large,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return renderLoading(
        child: Column(
      children: [
        Text(
          "myCommunities".toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.grey.shade400),
        ).tr(),
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
    ));
  }
}
