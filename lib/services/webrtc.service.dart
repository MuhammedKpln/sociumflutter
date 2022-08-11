import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart' as wrc;

final rtcConfig = {
  'iceServers': [
    {'url': 'stun:stun.l.google.com:19302'},
  ]
};

class PeerConnection {
  final wrc.RTCPeerConnection _peerConnection;
  final StreamController<wrc.RTCPeerConnectionState> connectionState =
      StreamController.broadcast();
  PeerConnection(this._peerConnection) {
    _onConnectionState();
  }

  wrc.RTCPeerConnection get events => _peerConnection;

  Future<wrc.MediaStream> getUserMedia({bool turnVideoOn = false}) async {
    const videoCons = {"facingMode": "user"};

    return await wrc.navigator.mediaDevices.getUserMedia(
        {"audio": true, "video": turnVideoOn ? videoCons : false});
  }

  Future<void> addStream(wrc.MediaStream stream) async {
    await _peerConnection.addStream(stream);
  }

  Future<wrc.RTCSessionDescription> createOffer() async {
    final description = await _peerConnection.createOffer();

    await _peerConnection.setLocalDescription(description);

    return description;
  }

  Future<wrc.RTCSessionDescription> createAnswer(
      wrc.RTCSessionDescription offer) async {
    await _peerConnection.setRemoteDescription(offer);
    final answer = await _peerConnection.createAnswer();
    await _peerConnection.setLocalDescription(answer);

    return answer;
  }

  Future<void> setRemoteDescription(wrc.RTCSessionDescription answer) async {
    await _peerConnection.setRemoteDescription(answer);
  }

  _onConnectionState() {
    _peerConnection.onConnectionState = (state) {
      connectionState.add(state);
    };
  }
}
