import 'package:auto_route/auto_route.dart';
import 'package:date_format/date_format.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/models/profile_settings_page.model.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/utils/router.gr.dart' as router;

class ProfileSettings extends ConsumerStatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends ConsumerState<ProfileSettings> {
  void navigateToScreen(dynamic screen) {
    AutoRouter.of(context).push(screen);
  }

  @override
  Widget build(BuildContext context) {
    print(AutoRouter.of(context).routeData.route.path);
    final user = ref.watch(userProvider).user;

    final List<Map<String, dynamic>> pages = [
      {
        "label": "Biyografi",
        "screen": router.BioSettingsRoute(),
        "value": user?.bio
      },
      {
        "label": "Doğum tarihi",
        "screen": const router.TestScreen(),
        "value": formatDate(user!.birthday!, [dd, ' ', MM, ' ', yyyy],
            locale: const TurkishDateLocale())
      },
      {
        "label": "Gelen aramaları engelle",
        "screen": const router.TestScreen(),
        "value": user.blockIncomingCalls! ? "Kapalı" : 'Açık'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profilini düzenle"),
      ),
      body: Column(children: [
        Expanded(
            flex: 1,
            child: ListView.separated(
                itemBuilder: ((context, index) {
                  final page = ProfileSettingsPageModal(
                      label: pages[index]["label"]!,
                      value: pages[index]["value"]!,
                      screen: pages[index]["screen"]);

                  return ListTile(
                    trailing: const Icon(
                      FeatherIcons.chevronRight,
                      color: Colors.white,
                    ),
                    title: Text(page.label),
                    subtitle: Text(
                      page.value,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.grey),
                    ),
                    onTap: () => navigateToScreen(page.screen),
                  );
                }),
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
                itemCount: pages.length))
      ]),
    );
  }
}