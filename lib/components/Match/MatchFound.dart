import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/LottieAnimation.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/models/user.dart';
import 'package:scflutter/services/websocket.events.dart';
import 'package:scflutter/theme/animations.dart';
import 'package:scflutter/theme/toast.dart';
import 'package:scflutter/utils/router.gr.dart';

import '../../models/room.dart';

class MatchFound extends StatefulWidget {
  const MatchFound(
      {Key? key,
      required this.user,
      required this.room,
      required this.userUUID,
      required this.socketService})
      : super(key: key);

  final UserModel user;
  final Room room;
  final String userUUID;
  final SocketService socketService;

  @override
  State<MatchFound> createState() => _MatchFoundState();
}

class _MatchFoundState extends State<MatchFound> {
  @override
  void initState() {
    super.initState();
    _setupLiseteners();
  }

  @override
  void dispose() {
    _disposeListeners();
    super.dispose();
  }

  void _setupLiseteners() {
    widget.socketService.onMatchRejected(() {
      context.toast.showToast("matchRejected".tr(), toastType: ToastType.Info);
      closeDialog();
    });
  }

  void _disposeListeners() {
    widget.socketService.socket.off(SocketListenerEvents.MATCH_REJECTED.path);
  }

  void rejectMatch() {
    widget.socketService.rejectMatch(widget.userUUID);
    closeDialog();
  }

  void closeDialog() {
    context.router.pop();
  }

  void sendMessage() {
    closeDialog();

    context.router.navigate(ChatNew(
        comingFromMatchedPage: true,
        connectedUser: widget.user,
        room: widget.room,
        userUUID: widget.userUUID,
        socketService: widget.socketService));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Column(
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
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: LottieAnimation(
                      animationPath: Animations.confetti.path,
                      heigth: 200,
                      width: 200,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Avatar(
                      username: widget.user.username,
                      avatarPath: widget.user.avatar,
                      avatarSize: AvatarSize.large,
                    ),
                  ),
                  Align(
                    heightFactor: 10,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      widget.user.username,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 200,
                child: RoundedButton.icon(
                  onPressed: sendMessage,
                  icon: const Icon(FeatherIcons.messageCircle, size: 20),
                  label:
                      const Text("matchScreenMatchFoundSendMessageBtnTxt").tr(),
                ),
              ),
              TextButton(
                  onPressed: rejectMatch,
                  child: const Text("matchScreenMatchFoundCloseBtnTxt").tr())
            ],
          )
        ],
      ),
    );
  }
}
