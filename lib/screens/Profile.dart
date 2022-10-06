import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/ChangeAvatar.dart';
import 'package:scflutter/components/LoadingNew.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/mixins/NewLoading.mixin.dart';
import 'package:scflutter/models/user.dart';
import 'package:scflutter/repositories/user.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/utils/palette.dart';

import '../utils/router.gr.dart';

class ProfilePage extends ConsumerStatefulWidget {
  ProfilePage({Key? key, required this.username}) : super(key: key);

  String username;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfilePage>
    with NewLoadingMixin<ProfilePage>, TickerProviderStateMixin {
  final UserRepository _userRepository = UserRepository();
  UserModel? user;
  UserMetaData? userMeta;

  bool get isFullScreen =>
      context.router.current.name == ProfilePageAsDialogRoute.name;

  void onPressSettings() {
    context.router.navigate(const SettingsRoute());
  }

  void onPressProfileSettings() {
    context.router.navigate(const ProfileSettingsScreenRoute());
  }

  fetchUserProfile() async {
    _userRepository.fetchUser(widget.username).then((value) async {
      final metaOutput = await fetchUserMeta();

      setLoading(false);
      setState(() {
        userMeta = metaOutput;
        user = value;
      });
    }).catchError(onError);
  }

  Future<UserMetaData> fetchUserMeta() async {
    final userId = ref.read(userProvider).rawUser!.id;

    return await _userRepository.fetchUserMeta(userId);
  }

  void navigateToFollowersPage({required bool fetchingFollowers}) {
    context.router
        .navigate(FollowersRoute(fetchingFollowers: fetchingFollowers));
  }

  void navigateToRoomsPage() {
    context.router.navigate(const RoomsRoute());
  }

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: renderAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 60),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                ColorPalette.surface.withOpacity(0.5),
                                ColorPalette.surface,
                              ],
                            )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Loading(
                                type: LoadingType.singleLine,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child:
                                          Text(user?.username ?? "No username"),
                                    ),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: ColorPalette.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    )
                                  ],
                                ),
                              ),
                              Loading(
                                type: LoadingType.singleLine,
                                child: Text(
                                  user?.biography ??
                                      "Herhangi bir bilgi bulunmamakta.",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                              userFollowerInformation(userMeta),
                              upgradeButton()
                            ]),
                      ),
                      renderAvatar(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget renderAvatar() {
    return Center(
      child: Container(
          transform: Matrix4.translationValues(0.0, -50, 0.0),
          child: ChangeAvatar(
            username: user?.username ?? "s",
            isAuthenticatedUser: !isFullScreen,
            avatar: user?.avatar,
          )),
    );
  }

  AppBar renderAppBar() {
    final List<Widget> actions = [
      IconButton(
          onPressed: onPressSettings, icon: const Icon(FeatherIcons.settings))
    ];
    final Widget editButton = IconButton(
        onPressed: onPressProfileSettings, icon: const Icon(FeatherIcons.edit));

    return AppBar(
      leading: !isFullScreen ? editButton : null,
      actions: !isFullScreen ? actions : null,
    );
  }

  Container upgradeButton() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 2),
          gradient: LinearGradient(
            colors: [
              ColorPalette.surface.withOpacity(0.5),
              ColorPalette.surface,
            ],
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Daha fazla özellik edinin",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Elmas'a yükseltin",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        RoundedButton(
          onPressed: () => ref.watch(userProvider.notifier).clearUser(),
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  const TextStyle(fontWeight: FontWeight.bold))),
          child: const Text("Yükselt"),
        )
      ]),
    );
  }

  Row userFollowerInformation(UserMetaData? data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () => navigateToFollowersPage(fetchingFollowers: false),
          child: Column(
            children: [
              Text(
                "TAKİP",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
              ),
              Loading(
                type: LoadingType.singleLine,
                child: Text(
                  data?.followings.round().toString() ?? "0",
                  style: TextStyle(
                      color: const Color(0xff8A84E2),
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () => navigateToFollowersPage(fetchingFollowers: true),
          child: Column(
            children: [
              Text(
                "TAKİPÇİ",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
              ),
              Loading(
                type: LoadingType.singleLine,
                child: Text(
                  data?.followers.round().toString() ?? "0",
                  style: TextStyle(
                      color: const Color(0xffF9A620),
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: navigateToRoomsPage,
          child: Column(
            children: [
              Text(
                "ODALAR",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
              ),
              Loading(
                type: LoadingType.singleLine,
                child: Text(
                  data?.rooms.round().toString() ?? "0",
                  style: TextStyle(
                      color: const Color(0xffD4AFCD),
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
