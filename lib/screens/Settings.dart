import 'package:flutter/material.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/components/Settings/ChangeLanguage.dart';
import 'package:scflutter/components/Settings/Logout.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<Widget> _settings = [SettingsChangeLanguage()];

  @override
  void initState() {
    super.initState();

    //Add logout last
    _settings.add(SettingsLogout());
  }

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
