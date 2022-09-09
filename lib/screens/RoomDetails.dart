import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/Badge.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/mixins/Loading.mixin.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/models/user.dart';
import 'package:scflutter/repositories/room.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/theme/toast.dart';
import 'package:scflutter/utils/router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/Avatar.dart';
import '../utils/palette.dart';

class RoomDetailsPage extends ConsumerStatefulWidget {
  RoomDetailsPage({Key? key, required this.roomId, this.onPop})
      : super(key: key);

  int roomId;
  VoidCallback? onPop;

  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends ConsumerState<RoomDetailsPage>
    with LoadingMixin {
  final RoomRepository _roomRepository = RoomRepository();
  late Room roomDetails;

  @override
  void initState() {
    super.initState();

    fetchRoomDetails();
  }

  @override
  void dispose() {
    widget.onPop?.call();
    super.dispose();
  }

  bool get isJoinedCommunity => roomDetails.room_partipications_data!
      .where(
          (element) => element.user == Supabase.instance.client.auth.user()!.id)
      .isNotEmpty;

  fetchRoomDetails() async {
    _roomRepository.fetchRoomDetails(roomId: widget.roomId).then((value) {
      setState(() {
        roomDetails = value;
        isLoading = false;
      });
    }).catchError(onError);
  }

  onPressViewAllMembers() {
    //TODO: implement
  }

  onPressJoinCommunity() async {
    final user = ref.read(userProvider).user;
    final userId = user!.id;

    _roomRepository
        .joinCommunity(roomId: widget.roomId, userId: userId)
        .then((value) {
      final newRoomPariciption = RoomPartipication(
          id: 0,
          room: widget.roomId,
          user: userId,
          created_at: DateTime.now(),
          user_data: user);
      final t = roomDetails.copyWith(room_partipications_data: [
        ...roomDetails.room_partipications_data!,
        newRoomPariciption
      ]);

      setState(() {
        roomDetails = t;
      });

      context.toast.showToast("Joined", toastType: ToastType.Success);
    }).catchError(onError);
  }

  onPressLeaveCommunity() async {
    final userId = Supabase.instance.client.auth.user()!.id;
    _roomRepository
        .leaveCommunity(roomId: widget.roomId, userId: userId)
        .then((value) {
      final userId = Supabase.instance.client.auth.user()!.id;

      final t = [...roomDetails.room_partipications_data!];
      t.removeWhere(
          (element) => element.user == userId && element.room == widget.roomId);
      setState(() {
        roomDetails = roomDetails.copyWith(room_partipications_data: t);
      });

      context.toast.showToast("Leaved", toastType: ToastType.Success);
    }).catchError(onError);
  }

  @override
  Widget build(BuildContext context) {
    return renderLoading(
        child: AppScaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                FutureBuilder(
                    future: Future.value(true),
                    builder: ((context, snapshot) {
                      return Column(
                        children: [renderDetails(), renderUsersSection()],
                      );
                    })),
              ],
            )));
  }

  void onTapUser(String username) {
    context.router.navigate(ProfilePageAsDialogRoute(username: username));
  }

  Widget renderUsersSection() {
    if (roomDetails.room_partipications_data!.isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "communityMembers".tr(namedArgs: {
                "memberCount":
                    roomDetails.room_partipications_data!.length.toString()
              }).toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.grey.shade400),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              UserModel? user =
                  roomDetails.room_partipications_data?[index].user_data;

              return ListTile(
                onTap: () => onTapUser(user?.username ?? "admin"),
                title: Text(user?.username ?? "??"),
                leading: Avatar(username: user?.username ?? "??"),
              );
            }),
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: roomDetails.room_partipications_data!.length,
          ),
          const Divider(),
          Center(
            child: TextButton(
                onPressed: onPressViewAllMembers,
                child: Text("viewAllMembersBtnTxt".tr().toUpperCase())),
          )
        ],
      ),
    );
  }

  Padding renderDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: ColorPalette.surfaceLinearGradient),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          Text(
                            roomDetails.name!,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          renderCategories(),
                        ],
                      ),
                      renderDescription(),
                      renderActionButtons()
                    ]),
              ),
              Container(
                  alignment: Alignment.center,
                  transform: Matrix4.translationValues(0.0, -50, 0.0),
                  child: Avatar(
                      username: roomDetails.name ?? "s",
                      avatarSize: AvatarSize.large)),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderDescription() {
    if (roomDetails.description == null) {
      return const SizedBox();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "aboutCommunity".tr().toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.grey.shade400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(roomDetails.description ?? "No description"),
        ),
      ],
    );
  }

  Widget renderActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        renderJoinButton(),
        RoundedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    ColorPalette.surface.withOpacity(0.3))),
            child: const Icon(FeatherIcons.messageCircle),
            onPressed: () => null)
      ],
    );
  }

  Widget renderJoinButton() {
    if (isJoinedCommunity) {
      return OutlinedButton(
          onPressed: onPressLeaveCommunity,
          child: Text("leaveCommunityBtnText".tr().toUpperCase()));
    }

    return RoundedButton(
        onPressed: onPressJoinCommunity,
        child: const Text("joinCommunityBtnText").tr());
  }

  Widget renderCategories() {
    if (roomDetails.category_data == null) {
      return SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: 200,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Badge(child: Text(roomDetails.category_data?.name ?? ""))
        ]),
      ),
    );
  }
}
