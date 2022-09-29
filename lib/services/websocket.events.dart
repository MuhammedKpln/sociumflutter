// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:scflutter/models/socket/media_permissions_response.dart';
import 'package:scflutter/models/user.dart';
import 'package:scflutter/services/websocket.service.dart';

enum SocketFireEvents {
  JoinQueue("join queue"),
  JoinRoom("join room"),
  LeaveQueue("leave queue"),
  AskForMedia("ask for media permission"),
  GiveMediaPermission("allow media controls"),
  LeaveRoom("leave room"),
  RejectMatch("reject match");

  final String path;
  const SocketFireEvents(this.path);
}

enum SocketListenerEvents {
  CLIENT_PAIRED("CLIENT_PAIRED"),
  MEDIA_PERMISSION_ASKED("MEDIA_PERMISSION_ASKED"),
  MEDIA_PERMISSION_ANSWERED("MEDIA_PERMISSION_ANSWERED"),
  CLIENT_DISCONNECTED('CLIENT_DISCONNECTED'),
  MATCH_REJECTED("MATCH_REJECTED");

  final String path;
  const SocketListenerEvents(this.path);
}

class SocketService extends SocketCore {
  askForMediaPermissions(String userUUID, {bool? audio, bool? video}) {
    emit(SocketFireEvents.AskForMedia.path,
        data: {"audio": audio, "video": video, "uuid": userUUID});
  }

  giveMediaPermission(String userUUID, {bool? audio, bool? video}) {
    emit(SocketFireEvents.GiveMediaPermission.path,
        data: {"audio": audio, "video": video, "uuid": userUUID});
  }

  rejectMatch(String connectedUserUuid) {
    emit(SocketFireEvents.RejectMatch.path, data: {"uuid": connectedUserUuid});
  }

  joinQueue(UserModel user) {
    emit(SocketFireEvents.JoinQueue.path, data: {"user": user.toJson()});
  }

  joinRoom(String roomUUID) {
    emit(SocketFireEvents.JoinRoom.path, data: {"room": roomUUID});
  }

  leaveQueue() {
    emit(SocketFireEvents.LeaveQueue.path);
  }

  leaveRoom(String roomName) {
    emit(SocketFireEvents.LeaveRoom.path, data: {"room": roomName});
  }

  onClientPaired(void Function(dynamic data) callback) {
    socket.on(SocketListenerEvents.CLIENT_PAIRED.path, (data) {
      callback(data);
    });
  }

  onMediaPermissionsAsked(void Function(MediaPermission response) callback) {
    socket.on(SocketListenerEvents.MEDIA_PERMISSION_ASKED.path, ((data) {
      final response = MediaPermission.fromJson(data);

      return callback(response);
    }));
  }

  onMediaPermissionAnswered(void Function(MediaPermission response) callback) {
    socket.on(SocketListenerEvents.MEDIA_PERMISSION_ANSWERED.path, ((data) {
      final response = MediaPermission.fromJson(data);

      return callback(response);
    }));
  }

  onMatchRejected(VoidCallback callback) {
    socket.on(SocketListenerEvents.MATCH_REJECTED.path, (data) => callback());
  }

  onClientDisconnected(VoidCallback callback) {
    socket.on(
        SocketListenerEvents.CLIENT_DISCONNECTED.path, ((data) => callback()));
  }
}
