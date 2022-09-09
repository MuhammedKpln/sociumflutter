import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/utils/palette.dart';

class SettingsLogout extends ConsumerWidget {
  const SettingsLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    VoidCallback logOut = () => ref.read(userProvider.notifier).clearUser();

    return ListTile(
      title: Text(
        "logoutBtnTxt",
        style: TextStyle(color: ColorPalette.red),
      ).tr(),
      onTap: logOut,
    );
  }
}
