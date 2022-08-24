import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/models/user.dart';

import '../../components/RoundedButton.dart';
import '../../components/Scaffold.dart';

class PermissionModal extends StatefulWidget {
  PermissionModal({
    Key? key,
    required this.askingForPermission,
    required this.user,
    required this.sendPermissionsAskedCallback,
    required this.acceptPermissionsAskedCallback,
    required this.audio,
    required this.video,
  }) : super(key: key);

  bool askingForPermission;
  UserModel user;
  bool audio;
  bool video;
  Function({required bool audio, required bool video})
      sendPermissionsAskedCallback;
  Function({required bool mediaPermissionsAllowed})
      acceptPermissionsAskedCallback;

  @override
  State<PermissionModal> createState() => _PermissionModalState();
}

class _PermissionModalState extends State<PermissionModal> {
  bool audio = false;
  bool video = false;

  @override
  void initState() {
    super.initState();
    audio = widget.audio;
    video = widget.video;
  }

  handleAudioOnpress({bool? audioParameter}) {
    if (!widget.askingForPermission) {
      return null;
    }

    setState(() {
      audio = audioParameter ?? !audio;
    });
  }

  handleVideoOnpress({bool? videoParameter}) {
    if (!widget.askingForPermission) {
      return null;
    }

    setState(() {
      audio = true;
      video = videoParameter ?? !video;
    });
  }

  handleActionButton() {
    if (widget.askingForPermission) {
      if (!audio && !video) {
        // If no permissions given, close the modal
        context.router.pop();
      }

      if (audio || video) {
        // Give/send permission to the user
        // Send permission
        widget.sendPermissionsAskedCallback.call(audio: true, video: true);
        context.router.pop();
        context.toast.showToast(widget.askingForPermission
            ? 'İsteğiniz gönderildi!'
            : 'İstek kabul edildi, arama butonu aktif.');
      }
    } else {
      if (!widget.audio && widget.video) {
        handleVideoOnpress(videoParameter: true);
      } else if (widget.audio && !widget.video) {
        handleAudioOnpress(audioParameter: true);
      }

      widget.acceptPermissionsAskedCallback.call(mediaPermissionsAllowed: true);

      // setState(() {
      //   mediaPermissionsAlllowed = true;
      // });

      // acceptPermissionsAsked(audio: audio, video: video);
      // context.router.pop();

      // scaffoldKey.currentState
      //     ?.showSnackBar(const SnackBar(content: Text("Istek kabul edildi")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            !widget.askingForPermission
                ? '${widget.user.username} sizi aramak için izin istedi.'
                : 'İstek türü',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          RoundedButton(
              style: ButtonStyle(
                  backgroundColor: audio
                      ? MaterialStateProperty.all(Colors.greenAccent)
                      : MaterialStateProperty.all(Colors.grey)),
              onPressed: handleAudioOnpress,
              child: Text(!widget.askingForPermission
                  ? "Sesli sohbete izin ver"
                  : "Sesli sohbet izini iste")),
          RoundedButton(
              style: ButtonStyle(
                  backgroundColor: video
                      ? MaterialStateProperty.all(Colors.indigoAccent)
                      : MaterialStateProperty.all(Colors.grey)),
              onPressed: handleVideoOnpress,
              child: Text(!widget.askingForPermission
                  ? "Görüntülü sohbete izin ver"
                  : "Görüntülü sohbet izini iste")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RoundedButton(
                  onPressed: handleActionButton,
                  child: Text(!widget.askingForPermission
                      ? "İsteği kabul et"
                      : 'İsteği yolla')),
              if (!widget.askingForPermission)
                RoundedButton(
                    onPressed: () => context.router.pop(),
                    child: const Text("İsteği reddet."))
            ],
          )
        ],
      ),
    ));
  }
}
