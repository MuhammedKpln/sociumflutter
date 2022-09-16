import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/LoadingNew.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/mixins/NewLoading.mixin.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/models/user.dart';
import 'package:scflutter/repositories/room.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/utils/router.gr.dart';

class RoomsPage extends ConsumerStatefulWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends ConsumerState<RoomsPage>
    with NewLoadingMixin, TickerProviderStateMixin {
  final RoomRepository _roomRepository = RoomRepository();
  UserModel? get user => ref.read(userProvider).user;
  List<RoomPartipication> joinedCommunities = [];

  @override
  void initState() {
    super.initState();

    fetchJoinedCommunities();
  }

  fetchJoinedCommunities() {
    _roomRepository.fetchJoinedRooms(userId: user!.id).then((value) {
      setLoading(false);
      setState(() {
        joinedCommunities = value;
      });
    }).catchError(onError);
  }

  void _navigateToRoomDetails(int roomId) async {
    await context.router.navigate(RoomDetailsRoute(roomId: roomId));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(user!.username),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          RoomPartipication community = joinedCommunities[index];
          String communityName = community.room_data?.name ?? "noName";
          String? communityDesc = community.room_data?.description;

          return Loading(
              type: LoadingType.list,
              child: ListTile(
                onTap: () => _navigateToRoomDetails(community.room_data!.id),
                title: Text(communityName),
                subtitle: communityDesc != null ? Text(communityDesc) : null,
                leading: Avatar(username: communityName),
              ));
        },
        itemCount: joinedCommunities.length,
      ),
    );
  }
}
