part of '../ChatNew.dart';

bool mediaPermissionsAlllowed = false;
bool audio = false;
bool video = false;
bool peerConnectionInitialized = false;

_resetState() {
  connectedToCall = ValueNotifier<bool>(false);
  audio = false;
  video = false;
  peerConnectionInitialized = false;
  mediaPermissionsAlllowed = false;
}

peerConnectionEnsureInitialized(
    {required SocketService socketService,
    required String userUUID,
    Function? permissionsAskedCallback,
    Function(MediaPermission payload)? mediaPermissionsAnswered,
    Function? onClientDisconnected}) async {
  _resetState();

  socketService.onMediaPermissionsAsked((response) {
    audio = response.audio != null ? response.audio! : audio;
    video = response.video != null ? response.video! : video;

    permissionsAskedCallback?.call();
  });

  socketService.onMediaPermissionAnswered((response) {
    mediaPermissionsAnswered?.call(response);
  });

  socketService.onClientDisconnected(() async {
    onClientDisconnected?.call();
  });

  // Future<void> upgradeCall(RTCSessionDescription offer) async {
  //   final MediaStream stream =
  //       await peerConnection.getUserMedia(turnVideoOn: true);
  //   localStream.value = stream;

  //   final videoTrack = localStream.value?.getVideoTracks()[0];
  //   await localStream.value?.addTrack(videoTrack!);
  //   await peerConnection.events.addTrack(videoTrack!, localStream.value!);

  //   final answer = await peerConnection.createAnswer(offer);
  //   socketService.makeAnswer(answer, userUUID);
  // }
}

disposeEvents(SocketService socketService) {
  try {
    connectedToCall.dispose();
  } catch (err) {
    print(err);
  }

  socketService.socket.off(SocketListenerEvents.MESSAGE_RECEIVED.path);
  socketService.socket.off(SocketListenerEvents.ANSWER_MADE.path);
  socketService.socket.off(SocketListenerEvents.CALL_MADE.path);
  socketService.socket.off(SocketListenerEvents.RECEIVED_ICE_CANDIDATE.path);
  socketService.socket.off(SocketListenerEvents.MEDIA_PERMISSION_ANSWERED.path);
  socketService.socket.off(SocketListenerEvents.MEDIA_PERMISSION_ASKED.path);
  socketService.socket.off(SocketListenerEvents.CLIENT_DISCONNECTED.path);
}
