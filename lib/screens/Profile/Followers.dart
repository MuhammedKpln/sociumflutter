import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/mixins/Loading.mixin.dart';
import 'package:scflutter/models/follower.dart';
import 'package:scflutter/repositories/follower.repository.dart';
import 'package:scflutter/state/auth.state.dart';

class FollowersPage extends ConsumerStatefulWidget {
  FollowersPage({Key? key, required this.fetchingFollowers}) : super(key: key);

  bool fetchingFollowers = false;

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends ConsumerState<FollowersPage>
    with LoadingMixin {
  final FollowerRepository _followerRepository = FollowerRepository();
  List<Follower> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.fetchingFollowers) {
      fetchUserFollowers();
    } else {
      fetchUserFollowings();
    }
  }

  String get userId => ref.read(userProvider).user!.id;

  fetchUserFollowers() {
    _followerRepository.fetchUserFollowers(userId).then((value) {
      setState(() {
        users = value;
        isLoading = false;
      });
    }).catchError(onError);
  }

  fetchUserFollowings() {
    _followerRepository.fetchUserFollowings(userId).then((value) {
      setState(() {
        users = value;
        isLoading = false;
      });
    }).catchError(onError);
  }

  void navigateToUserProfile() async {
    //TODO: implement
    context.router.navigateBack();
  }

  @override
  Widget build(BuildContext context) {
    return renderLoading(
        child: AppScaffold(
            appBar: AppBar(),
            body: ListView.separated(
                itemBuilder: (context, index) {
                  final user = users[index];
                  String username = "";

                  if (widget.fetchingFollowers) {
                    username = user.user_data!.username;
                  }

                  if (!widget.fetchingFollowers) {
                    username = user.actor_data!.username;
                  }

                  return ListTile(
                    onTap: navigateToUserProfile,
                    title: Text(username),
                    leading: Avatar(username: username),
                  );
                },
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
                itemCount: users.length)));
  }
}
