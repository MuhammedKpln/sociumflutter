part of '../ChatNew.dart';

ValueNotifier<bool> connectedToCall = ValueNotifier<bool>(false);
bool mediaPermissionsAlllowed = false;
bool audio = false;
bool video = false;
bool peerConnectionInitialized = false;
late PeerConnection peerConnection;

peerConnectionEnsureInitialized(
    {required SocketService socketService,
    required String userUUID,
    Function? permissionsAskedCallback,
    Function(MediaPermission payload)? mediaPermissionsAnswered,
    Function? onClientDisconnected}) async {
  final webRtcService = await createPeerConnection(rtcConfig);
  peerConnection = PeerConnection(webRtcService);

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

    print("seqeqweq");
    permissionsAskedCallback?.call();

    // showModalBottomSheet(
    //     context: context,
    //     builder: (context) => handlePermissionsModal(context, setState,
    //         askingForPermission: false));
  });

  socketService.onMediaPermissionAnswered((response) {
    mediaPermissionsAnswered?.call(response);
    // setState(() {
    //   mediaPermissionsAlllowed = true;
    // });
  });

  socketService.onClientDisconnected(() async {
    onClientDisconnected?.call();

    // context.toast.showToast("Kullanıcı çıkış yaptı");
    // await context.router.pop();
  });
}

disposeEvents(SocketService socketService) {
  try {
    localStream.dispose();
    connectedToCall.dispose();
    chatMicMuted.dispose();
    chatCameraOpened.dispose();
    remoteStream.dispose();
    peerConnection.connectionState.close();
  } catch (err) {}

  socketService.socket.off(SocketListenerEvents.MESSAGE_RECEIVED.path);
  socketService.socket.off(SocketListenerEvents.ANSWER_MADE.path);
  socketService.socket.off(SocketListenerEvents.CALL_MADE.path);
  socketService.socket.off(SocketListenerEvents.RECEIVED_ICE_CANDIDATE.path);
  socketService.socket.off(SocketListenerEvents.MEDIA_PERMISSION_ANSWERED.path);
  socketService.socket.off(SocketListenerEvents.MEDIA_PERMISSION_ASKED.path);
  socketService.socket.off(SocketListenerEvents.CLIENT_DISCONNECTED.path);
}
