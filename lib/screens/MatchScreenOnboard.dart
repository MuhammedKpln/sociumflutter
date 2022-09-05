import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/utils/router.gr.dart';

import '../utils/palette.dart';

class MatchScreenOnboardPage extends ConsumerWidget {
  const MatchScreenOnboardPage({Key? key}) : super(key: key);

  void changeTab(int index, TabsRouter context) {
    context.setActiveIndex(index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider.notifier);

    return AutoTabsRouter(
      routes: const [MatchScreenRoute(), CommunitiesTab()],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return AppScaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(FeatherIcons.moreHorizontal),
                onPressed: () => user.clearUser(),
              ),
              title:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => changeTab(0, tabsRouter),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 100,
                          decoration: BoxDecoration(
                              color: tabsRouter.activeIndex == 0
                                  ? ColorPalette.primary
                                  : null,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Icon(FeatherIcons.globe,
                              color: ColorPalette.grey, size: 15),
                        ),
                      ),
                      InkWell(
                        onTap: () => changeTab(1, tabsRouter),
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: tabsRouter.activeIndex == 1
                                  ? ColorPalette.primary
                                  : null,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Icon(FeatherIcons.users,
                              size: 15, color: ColorPalette.grey),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
            body: FadeTransition(
              opacity: animation,
              child: child,
            ));
      },
    );
  }
}
