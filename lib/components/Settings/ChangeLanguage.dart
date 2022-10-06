import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/repositories/user.repository.dart';
import 'package:scflutter/theme/toast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsChangeLanguage extends StatefulWidget {
  const SettingsChangeLanguage({super.key});

  @override
  State<SettingsChangeLanguage> createState() => SettingsChangeLanguageState();
}

class SettingsChangeLanguageState extends State<SettingsChangeLanguage> {
  final UserRepository _userRepository = UserRepository();

  void onChangedLanguage(Locale? value) async {
    final userId = Supabase.instance.client.auth.currentUser!.id;

    await context.setLocale(value!);
    await _userRepository.saveLocale(value.languageCode, userId);
    context.toast.showToast("success".tr(), toastType: ToastType.Success);
  }

  List<Locale> get _languages => context.supportedLocales;

  List<DropdownMenuItem<Locale>> get languageMenuItem => _languages
      .map<DropdownMenuItem<Locale>>((Locale locale) => DropdownMenuItem(
            value: Locale(locale.languageCode),
            child: Text(locale.languageCode.toUpperCase()),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("settingsChangeLang").tr(),
      trailing: DropdownButton<Locale>(
        onChanged: (Locale? val) => onChangedLanguage(val),
        value: context.locale,
        items: languageMenuItem,
      ),
    );
  }
}
