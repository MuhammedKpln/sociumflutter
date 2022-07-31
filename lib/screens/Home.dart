import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/utils/router.gr.dart';

import '../utils/palette.dart';

class HomeScreenPage extends ConsumerWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(userProvider);

    if (notifier.accessToken == null) {
      AutoRouter.of(context).replace(const OnboardScreenRoute());
    }

    return Scaffold(
        body: AutoTabsScaffold(
      routes: const [
        MatchScreenRoute(),
        ChatsScreenRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          backgroundColor: ColorPalette.surface,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.messageCircle), label: "Chats"),
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.user), label: "Profile")
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        );
      },
    ));
  }
}
