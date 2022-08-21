import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/Loading.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/graphql/graphql_api.dart';
import 'package:scflutter/models/user.dart' as UserModel;
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../mixins/Loading.mixin.dart';
import '../utils/router.gr.dart';

class ProfilePage extends ConsumerStatefulWidget {
  ProfilePage({Key? key, required this.username}) : super(key: key);

  String username;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfilePage> with LoadingMixin {
  final client = Supabase.instance.client;
  late UserModel.User user;

  void onPressSettings() {
    context.router.navigate(const ProfileSettingsScreenRoute());
  }

  onError(error) {
    //TODO: implelemtn
  }

  fetchUserProfile() async {
    final fetch = await client
        .from("users")
        .select()
        .eq("username", widget.username)
        .single()
        .execute();

    if (!fetch.hasError) {
      final parsedUser = UserModel.User.fromJson(fetch.data);

      setState(() {
        isLoading = false;
        user = parsedUser;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Loading();
    }

    return AppScaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: onPressSettings, icon: const Icon(FeatherIcons.edit)),
          actions: [
            IconButton(
                onPressed: onPressSettings,
                icon: const Icon(FeatherIcons.settings))
          ],
        ),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(user.username),
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
                              Text(
                                //FIXME: implement
                                user.biography ??
                                    "Herhangi bir bilgi bulunmamakta.",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              //FIXME: implement
                              // userFollowerInformation();
                              upgradeButton()
                            ]),
                      ),
                      Center(
                        child: Container(
                            transform: Matrix4.translationValues(0.0, -50, 0.0),
                            child: const Avatar(
                                //FIXME: implement
                                username: "q",
                                avatarSize: AvatarSize.large)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
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

  Row userFollowerInformation(GetUserProfile$Query$GetUser$$count data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              "TAKİP",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
            ),
            Text(
              data.followings.round().toString(),
              style: TextStyle(
                  color: const Color(0xff8A84E2),
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize),
            )
          ],
        ),
        Column(
          children: [
            Text(
              "TAKİPÇİ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
            ),
            Text(
              data.followers.round().toString(),
              style: TextStyle(
                  color: const Color(0xffF9A620),
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize),
            )
          ],
        ),
        Column(
          children: [
            Text(
              "ODALAR",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
            ),
            Text(
              "32",
              style: TextStyle(
                  color: const Color(0xffD4AFCD),
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize),
            )
          ],
        ),
      ],
    );
  }
}
