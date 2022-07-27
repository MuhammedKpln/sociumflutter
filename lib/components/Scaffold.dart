import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart';

class AppScaffold extends StatefulWidget {
  AppScaffold({Key? key, this.appBar, required this.body}) : super(key: key);
  AppBar? appBar;
  Widget body;

  @override
  State<AppScaffold> createState() => AppScaffoldState();
}

class AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        MatchScreen(),
        ChatsScreen(),
        ProfileScreen(),
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
    );
  }
}
