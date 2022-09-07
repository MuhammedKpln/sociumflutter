import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/theme/toast.dart';

class SettingsChangeLanguage extends StatefulWidget {
  const SettingsChangeLanguage({super.key});

  @override
  State<SettingsChangeLanguage> createState() => SettingsChangeLanguageState();
}

class SettingsChangeLanguageState extends State<SettingsChangeLanguage> {
  void onChangedLanguage(Locale? value) async {
    await context.setLocale(value!);

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
      title: Text("settingsChangeLang").tr(),
      trailing: DropdownButton<Locale>(
        onChanged: (Locale? val) => onChangedLanguage(val),
        value: context.locale,
        items: languageMenuItem,
      ),
    );
  }
}
