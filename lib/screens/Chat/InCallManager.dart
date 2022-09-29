import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_call_ui/flutter_call_ui.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:scflutter/utils/avatar.dart';
import 'package:scflutter/utils/palette.dart';

class InCallManagerScreenPage extends StatefulWidget {
  const InCallManagerScreenPage({
    Key? key,
    required this.username,
    required this.userAvatar,
    required this.onPressHangup,
    required this.localStream,
    required this.remoteStream,
  }) : super(key: key);

  final String username;
  final String userAvatar;
  final VoidCallback onPressHangup;
  final MediaStream localStream;
  final MediaStream remoteStream;

  @override
  State<InCallManagerScreenPage> createState() =>
      _InCallManagerScreenPageState();
}

class _InCallManagerScreenPageState extends State<InCallManagerScreenPage> {
  bool fullScreen = false;
  CameraState cameraState = CameraState.closed;
  MicState micState = MicState.closed;

  @override
  void initState() {
    super.initState();
    _switchCameraState();
  }

  void _switchCameraState() {
    final stream = widget.remoteStream;
    final tracks = stream.getVideoTracks();

    if (tracks.isNotEmpty) {
      setState(() {
        cameraState = CameraState.front;
      });
    }
  }

  PreferredSizeWidget _renderAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(FeatherIcons.arrowLeft),
        onPressed: () => context.router.navigateBack(),
      ),
    );
  }

  void _toggleFullScreen() {
    setState(() {
      fullScreen = !fullScreen;
    });
  }

  Future<void> _onPressCamera() async {
    final stream = widget.remoteStream;
    final tracks = stream.getVideoTracks();

    await Helper.switchCamera(tracks[0]);
  }

  _onPressMic() {
    final stream = widget.remoteStream;
    final tracks = stream.getAudioTracks();
    final bool state = micState == MicState.closed ? true : false;

    for (var track in tracks) {
      track.enabled = state;
    }

    setState(() {
      if (state) {
        micState = MicState.open;
      } else {
        micState = MicState.closed;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CallUI(
      remoteStream: widget.remoteStream,
      localStream: widget.localStream,
      onPressCamera: _onPressCamera,
      onPressHangup: widget.onPressHangup,
      onPressMic: _onPressMic,
      user: CallUserModel(
          avatar: generateAvatarUrl(widget.userAvatar),
          username: widget.username),
      appBarScaffold: _renderAppBar(),
      cameraState: cameraState,
      micState: micState,
      fullScreen: fullScreen,
      locale: const CallTRLocale(),
      onPressContainer: _toggleFullScreen,
      theme: const CallUIDefaultTheme(
          backgoundColor: ColorPalette.background,
          iconColor: Colors.white,
          redColor: ColorPalette.red,
          secondaryColor: ColorPalette.primary),
    );
  }
}
