import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/models/profile_settings_page.model.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/utils/date.dart';
import 'package:scflutter/utils/router.gr.dart' as router;

import '../../components/Scaffold.dart';

class ProfileSettingsScreenPage extends ConsumerStatefulWidget {
  const ProfileSettingsScreenPage({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends ConsumerState<ProfileSettingsScreenPage> {
  void navigateToScreen(dynamic screen) {
    AutoRouter.of(context).push(screen);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).user;

    final List<Map<String, dynamic>> pages = [
      {
        "label": "bioSettingsTitle".tr(),
        "screen": const router.BioSettingsRoute(),
        "value": user?.biography ?? "noInformationFound".tr()
      },
      {
        "label": "birthdaySettingsTitle".tr(),
        "screen": const router.BirthdaySettingsRoute(),
        "value": formatDate(user?.birthday ?? DateTime.now())
      },
      {
        "label": "blockIncomingCallsSettingsTitle".tr(),
        "screen": const router.BlockIncomingCallsScreenRoute(),
        "value": user!.blockIncomingCalls! ? "blocked".tr() : "unblocked".tr()
      }
    ];

    return AppScaffold(
      appBar: AppBar(
        title: const Text("profileSettingsTitle").tr(),
      ),
      body: Column(children: [
        Expanded(
            child: ListView.separated(
                itemBuilder: ((context, index) {
                  final page = ProfileSettingsPageModal(
                      label: pages[index]["label"]!,
                      value: pages[index]["value"] ?? "noInformationFound".tr(),
                      screen: pages[index]["screen"]);

                  return ListTile(
                    trailing: const Icon(
                      FeatherIcons.chevronRight,
                      color: Colors.white,
                    ),
                    title: Text(page.label),
                    subtitle: page.value != null
                        ? Text(
                            page.value,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: Colors.grey),
                          )
                        : null,
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
