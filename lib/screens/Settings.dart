import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/components/Settings/ChangeLanguage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<Widget> _settings = [SettingsChangeLanguage()];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return _settings[index];
          },
          itemCount: _settings.length,
        ));
  }
}
