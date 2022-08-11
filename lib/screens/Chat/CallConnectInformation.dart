import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:nil/nil.dart';
import 'package:scflutter/theme/animation_durations.dart';
import 'package:scflutter/utils/palette.dart';

import '../../services/webrtc.service.dart';

class CallConnectInformation extends StatefulWidget {
  CallConnectInformation({Key? key, required this.peerConnection})
      : super(key: key);

  PeerConnection peerConnection;

  @override
  State<CallConnectInformation> createState() => _CallConnectInformationState();
}

class _CallConnectInformationState extends State<CallConnectInformation> {
  bool failed = false;
  bool connected = false;
  bool showInformation = false;

  @override
  void initState() {
    super.initState();

    widget.peerConnection.connectionState.stream.listen((state) {
      switch (state) {
        case RTCPeerConnectionState.RTCPeerConnectionStateConnecting:
          setState(() {
            showInformation = true;
          });
          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
          setState(() {
            connected = true;
          });
          break;
        default:
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget renderChild(Key key) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: connected ? ColorPalette.green : null,
        gradient: !connected ? ColorPalette.bgLinearGradient : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            FeatherIcons.phoneCall,
            color: Colors.white,
          ),
          Text(!connected ? "Bağlanılıyor.." : "Bağlandı.")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showInformation) {
      return AnimatedSlide(
          offset: connected ? const Offset(2, 0) : const Offset(0, 0),
          duration: Duration(milliseconds: AnimationDurations.high.duration),
          curve: Curves.fastOutSlowIn,
          child: renderChild(UniqueKey()));
    }

    return nil;
  }
}
