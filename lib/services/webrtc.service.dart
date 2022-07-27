import 'package:flutter_webrtc/flutter_webrtc.dart' as wrc;

final rtcConfig = {
  'iceServers': [
    {'url': 'stun:stun.l.google.com:19302'},
  ]
};

class PeerConnection {
  wrc.RTCPeerConnection peerConnection;
  PeerConnection(this.peerConnection);

  Future<wrc.MediaStream> getUserMedia() async {
    return await wrc.navigator.mediaDevices
        .getUserMedia({"audio": true, "video": true});
  }

  Future<void> addStream(wrc.MediaStream stream) async {
    await peerConnection.addStream(stream);
  }

  Future<wrc.RTCSessionDescription> createOffer() async {
    final description = await peerConnection.createOffer();

    await peerConnection.setLocalDescription(description);

    return description;
  }

  Future<wrc.RTCSessionDescription> createAnswer(
      wrc.RTCSessionDescription offer) async {
    await peerConnection.setRemoteDescription(offer);
    final answer = await peerConnection.createAnswer();
    await peerConnection.setLocalDescription(answer);

    return answer;
  }
}
