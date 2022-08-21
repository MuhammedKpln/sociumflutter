import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/models/message.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:scflutter/services/websocket.events.dart';
import 'package:scflutter/theme/animations.dart';
import 'package:scflutter/utils/router.gr.dart';

class MatchFound extends StatelessWidget {
  MatchFound(
      {Key? key,
      required this.user,
      required this.room,
      required this.userUUID,
      required this.socketService})
      : super(key: key);

  User user;
  Room room;
  String userUUID;
  SocketService socketService;

  @override
  Widget build(BuildContext context) {
    void closeDialog() {
      context.router.pop();
    }

    void sendMessage() {
      closeDialog();

      context.router.navigate(ChatScreenRoute(
          comingFromMatchedPage: true,
          connectedUser: user,
          room: room,
          userUUID: userUUID,
          socketService: socketService));
    }

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Stack(alignment: Alignment.center, fit: StackFit.expand, children: [
        Lottie.asset(Animations.confetti.path,
            frameRate: FrameRate.max, height: 100),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'matchScreenMatchFoundTitle',
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(),
                ),
                Avatar(
                  username: user.username!,
                  avatarSize: AvatarSize.large,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    user.username ?? "No username",
                    style: const TextStyle(
                        color: Colors.white, decoration: TextDecoration.none),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                RoundedButton(
                  onPressed: sendMessage,
                  icon: const Icon(EvaIcons.messageCircleOutline, size: 20),
                  child:
                      const Text("matchScreenMatchFoundSendMessageBtnTxt").tr(),
                ),
                TextButton(
                    onPressed: () => AutoRouter.of(context).pop(),
                    child: const Text("matchScreenMatchFoundCloseBtnTxt").tr())
              ],
            )
          ],
        ),
      ]),
    );
  }
}
