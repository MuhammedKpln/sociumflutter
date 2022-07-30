import 'dart:async';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class CallComing extends StatefulWidget {
  const CallComing(
      {Key? key,
      required this.username,
      required this.onAcceptCall,
      required this.onRejectCall})
      : super(key: key);

  final String username;
  final Function onAcceptCall;
  final Function onRejectCall;

  @override
  State<CallComing> createState() => _CallComingState();
}

class _CallComingState extends State<CallComing> {
  late Timer hapticTimer;
  late Timer ringtoneTimer;

  @override
  void initState() {
    super.initState();

    hapticTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      await HapticFeedback.heavyImpact();
    });

    ringtoneTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FlutterRingtonePlayer.playRingtone();
    });
  }

  @override
  void dispose() {
    super.dispose();

    FlutterRingtonePlayer.stop();
    ringtoneTimer.cancel();
    hapticTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            Avatar(avatarSize: AvatarSize.large),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "${widget.username} arıyor..",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.red,
              ),
              child: IconButton(
                  onPressed: () => widget.onRejectCall(),
                  icon: const Icon(FeatherIcons.phoneForwarded)),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.green,
              ),
              child: IconButton(
                  onPressed: () => widget.onAcceptCall(),
                  icon: const Icon(FeatherIcons.phoneOff)),
            )
          ],
        ),
      ]),
    );
  }
}