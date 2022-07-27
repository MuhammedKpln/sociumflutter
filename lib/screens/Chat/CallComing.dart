import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class CallComing extends StatelessWidget {
  const CallComing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(children: [
        IconButton(onPressed: () => null, icon: const Icon(FeatherIcons.mic))
      ]),
    );
  }
}
