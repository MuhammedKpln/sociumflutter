import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/main.dart';
import 'package:scflutter/screens/Chat.dart';
import 'package:scflutter/utils/palette.dart';

class InCallManagerScreenPage extends StatefulWidget {
  InCallManagerScreenPage(
      {Key? key, required this.username, required this.onPressHangup})
      : super(key: key);

  String username;
  VoidCallback onPressHangup;

  @override
  State<InCallManagerScreenPage> createState() =>
      _InCallManagerScreenPageState();
}

class _InCallManagerScreenPageState extends State<InCallManagerScreenPage> {
  DateTime date = DateTime(DateTime.now().year, 0, 0, 0, 0, 0, 0, 0);
  late Timer timer;
  RTCVideoRenderer remoteRenderer = RTCVideoRenderer();
  RTCVideoRenderer localRenderer = RTCVideoRenderer();
  bool fullScreen = false;
  bool inVideoCall = false;
  Offset cameraOffset = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    remoteRenderer.initialize();
    localRenderer.initialize();

    localStream.addListener(() {
      localRenderer.srcObject = localStream.value;
    });

    remoteStream.addListener(() {
      remoteRenderer.srcObject = remoteStream.value;

      setState(() {
        inVideoCall = true;
      });
    });

    chatCameraOpened.addListener(() {
      if (chatCameraOpened.value) {
        setState(() {
          inVideoCall = true;
        });
      } else {
        setState(() {
          inVideoCall = false;
        });
      }
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        date = date.add(const Duration(seconds: 1));
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    remoteRenderer.dispose();
    localRenderer.dispose();

    timer.cancel();
  }

  void switchCamera() {
    scaffoldKey.currentState
        ?.showSnackBar(const SnackBar(content: Text("In progress")));
    // Helper.switchCamera(stream.getVideoTracks()[0]);
  }

  openCamera() async {
    chatCameraOpened.value = true;

    setState(() {
      inVideoCall = true;
    });
  }

  Widget actionButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: ColorPalette.surface.withOpacity(0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedButton(
              onPressed: () {
                chatMicMuted.value = !chatMicMuted.value;
                // widget.micMuted.value = !widget.micMuted.value;
              },
              icon: Icon(
                  chatMicMuted.value ? FeatherIcons.micOff : FeatherIcons.mic),
              child: const Text("")),
          RoundedButton(
              onPressed: inVideoCall ? switchCamera : openCamera,
              icon: inVideoCall
                  ? const Icon(Icons.flip_camera_ios_outlined)
                  : const Icon(FeatherIcons.camera),
              child: const Text("")),
          RoundedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ColorPalette.red)),
              onPressed: widget.onPressHangup,
              icon: const Icon(FeatherIcons.phoneOff),
              child: const Text("")),
        ],
      ),
    );
  }

  Widget renderCameraView() {
    onDragEnd(DraggableDetails details) {
      setState(() {
        cameraOffset = details.offset;
      });
    }

    final localCamera = RTCVideoView(
      localRenderer,
      mirror: true,
      filterQuality: FilterQuality.high,
      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
    );

    final remoteCamera = RTCVideoView(
      remoteRenderer,
      mirror: true,
      filterQuality: FilterQuality.high,
      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
    );

    final userCameraWidget = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 150,
        height: 200,
        child: localCamera,
      ),
    );

    return Stack(alignment: Alignment.bottomCenter, children: [
      GestureDetector(
        onTap: () {
          setState(() {
            fullScreen = !fullScreen;
          });
        },
        child: remoteCamera,
      ),
      Positioned(
        top: cameraOffset.dy,
        left: cameraOffset.dx,
        child: Draggable(
          childWhenDragging: Container(),
          feedback: Opacity(opacity: .4, child: userCameraWidget),
          onDragEnd: onDragEnd,
          child: userCameraWidget,
        ),
      ),
      AnimatedOpacity(
          opacity: fullScreen ? 0 : 1,
          duration: const Duration(milliseconds: 100),
          child: actionButtons())
    ]);
  }

  Widget renderCallView() {
    final callTimer = formatDate(date, [HH, ':', nn, ':', ss]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Avatar(
              avatarSize: AvatarSize.large,
              username: widget.username,
            ),
            Text(widget.username),
            Text(callTimer)
          ],
        ),
        actionButtons()
      ],
    );
  }

  PreferredSizeWidget? appBar() {
    if (fullScreen) {
      return null;
    }

    return AppBar(
      backgroundColor: ColorPalette.background.withOpacity(.3),
    );
  }

  Widget withSafeArea({required Widget child}) {
    if (inVideoCall) {
      return child;
    }

    return SafeArea(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: appBar(),
      body: withSafeArea(
          child: Center(
        child: inVideoCall ? renderCameraView() : renderCallView(),
      )),
    );
  }
}
