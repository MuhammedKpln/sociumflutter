import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      routes: [MatchScreen(), ProfileScreen()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: "Profile")
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        );
      },
    );
  }
}
