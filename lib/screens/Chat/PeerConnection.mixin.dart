import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:scflutter/services/websocket.events.dart';

import '../../services/webrtc.service.dart';

mixin PeerConnectionMixin {
  ValueNotifier<bool> connectedToCall = ValueNotifier<bool>(false);
  bool mediaPermissionsAlllowed = false;
  bool audio = false;
  bool video = false;
  bool peerConnectionInitialized = false;
  late PeerConnection peerConnection;
  ValueNotifier<bool> chatMicMuted = ValueNotifier<bool>(false);
  ValueNotifier<bool> chatCameraOpened = ValueNotifier<bool>(false);
  ValueNotifier<MediaStream?> remoteStream = ValueNotifier(null);
  ValueNotifier<MediaStream?> localStream = ValueNotifier(null);

  ensureInitialized(
      {required SocketService socketService,
      required String userUUID,
      Function? permissionsAskedCallback,
      Function? mediaPermissionsAnswered,
      Function? onClientDisconnected}) {
    peerConnection.connectionState.stream.listen((state) {
      switch (state) {
        case RTCPeerConnectionState.RTCPeerConnectionStateClosed:
          connectedToCall.value = false;
          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateDisconnected:
          connectedToCall.value = false;
          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateConnecting:
          connectedToCall.value = false;
          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
          connectedToCall.value = true;
          break;
        default:
          connectedToCall.value = false;
      }
    });

    socketService.onAnswerMade((data) async {
      final answer =
          RTCSessionDescription(data.answer["sdp"], data.answer["type"]);

      await peerConnection.setRemoteDescription(answer);
    });

    chatMicMuted.addListener(() {
      // FIXME: does not work when camera is opened?
      if (!chatMicMuted.value) {
        localStream.value
            ?.getAudioTracks()
            .forEach((track) => track.enabled = true);
      } else {
        localStream.value
            ?.getAudioTracks()
            .forEach((track) => track.enabled = false);
      }
    });

    chatCameraOpened.addListener(() async {
      if (chatCameraOpened.value) {
        final MediaStream stream =
            await peerConnection.getUserMedia(turnVideoOn: true);
        localStream.value = stream;
        final videoTrack = localStream.value?.getVideoTracks()[0];

        await localStream.value?.addTrack(videoTrack!);
        await peerConnection.events.addTrack(videoTrack!, localStream.value!);

        final offer = await peerConnection.createOffer();
        socketService.callUser(offer, userUUID);
      }
    });

    connectedToCall.addListener(() {
      // if (connectedToCall.value) {
      //   floatinActionButtonAnimatorTimer =
      //       Timer.periodic(const Duration(milliseconds: 700), (timer) {
      //     if (floatinActionButtonScale == 1) {
      //       setState(() {
      //         floatinActionButtonScale = 0.5;
      //       });
      //     } else {
      //       setState(() {
      //         floatinActionButtonScale = 1;
      //       });
      //     }
      //   });

      //   navigateToCallManager();
      // }

      //FIXME: hopp
      // if (context.router.isRouteActive(InCallManagerScreenRoute.name)) {
      //   context.router.pop();
      // }
    });

    peerConnection.events.onIceCandidate = (candidate) {
      socketService.addIceCandidate(candidate, userUUID);
    };

    peerConnection.events.onAddStream = ((stream) {
      final videoTracksLength = stream.getVideoTracks().length;

      if (videoTracksLength > 0) {
        remoteStream.value = stream;
      }
    });

    socketService.onMediaPermissionsAsked((response) {
      audio = response.audio != null ? response.audio! : audio;
      video = response.video != null ? response.video! : video;

      permissionsAskedCallback?.call();

      // showModalBottomSheet(
      //     context: context,
      //     builder: (context) => handlePermissionsModal(context, setState,
      //         askingForPermission: false));
    });

    socketService.onMediaPermissionAnswered((response) {
      if (audio || video) {
        mediaPermissionsAnswered?.call();
        // setState(() {
        //   mediaPermissionsAlllowed = true;
        // });
      }
    });

    socketService.onClientDisconnected(() async {
      onClientDisconnected?.call();

      // context.toast.showToast("Kullanıcı çıkış yaptı");
      // await context.router.pop();
    });
  }
}
