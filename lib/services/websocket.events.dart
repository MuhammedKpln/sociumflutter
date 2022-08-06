// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:scflutter/models/socket/answer_made_response.dart';
import 'package:scflutter/models/socket/call_made_response.dart';
import 'package:scflutter/models/socket/media_permissions_response.dart';
import 'package:scflutter/models/socket/on_ice_candidate_response.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:scflutter/services/websocket.service.dart';

import '../models/socket/message_received_response.dart';
import '../models/socket/send_message_arguments.dart';

enum SocketFireEvents {
  JoinQueue("join queue"),
  JoinRoom("join room"),
  LeaveQueue("leave queue"),
  CallUser("call user"),
  MakeAnswer("make answer"),
  AddIceCandidate("add ice candidate"),
  AskForMedia("ask for media permission"),
  GiveMediaPermission("allow media controls"),
  SendMessage("send message"),
  LeaveRoom("leave room");

  final String path;
  const SocketFireEvents(this.path);
}

enum SocketListenerEvents {
  CLIENT_PAIRED("CLIENT_PAIRED"),
  MESSAGE_RECEIVED("MESSAGE_RECEIVED"),
  CALL_MADE("CALL_MADE"),
  RECEIVED_ICE_CANDIDATE("RECEIVED_ICE_CANDIDATE"),
  MEDIA_PERMISSION_ASKED("MEDIA_PERMISSION_ASKED"),
  MEDIA_PERMISSION_ANSWERED("MEDIA_PERMISSION_ANSWERED"),
  ANSWER_MADE('ANSWER_MADE'),
  CLIENT_DISCONNECTED('CLIENT_DISCONNECTED');

  final String path;
  const SocketListenerEvents(this.path);
}

class SocketService extends SocketCore {
  callUser(RTCSessionDescription offer, String userUUID) {
    emit(SocketFireEvents.CallUser.path,
        data: {"offer": offer.toMap(), "uuid": userUUID});
  }

  askForMediaPermissions(String userUUID, {bool? audio, bool? video}) {
    emit(SocketFireEvents.AskForMedia.path,
        data: {"audio": audio, "video": video, "uuid": userUUID});
  }

  giveMediaPermission(String userUUID, {bool? audio, bool? video}) {
    emit(SocketFireEvents.GiveMediaPermission.path,
        data: {"audio": audio, "video": video, "uuid": userUUID});
  }

  makeAnswer(RTCSessionDescription answer, String userUUID) {
    emit(SocketFireEvents.MakeAnswer.path,
        data: {"answer": answer.toMap(), "uuid": userUUID});
  }

  addIceCandidate(RTCIceCandidate candidate, String uuid) {
    emit(SocketFireEvents.AddIceCandidate.path,
        data: {"candidate": candidate.toMap(), "uuid": uuid});
  }

  joinQueue(User user) {
    emit(SocketFireEvents.JoinQueue.path, data: {"user": user.toJson()});
  }

  joinRoom(String roomUUID) {
    emit(SocketFireEvents.JoinRoom.path, data: {"room": roomUUID});
  }

  sendMessage(SendMessageArguments sendMessageArguments) {
    emit(SocketFireEvents.SendMessage.path,
        data: sendMessageArguments.toJson());
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

  onCallMade(void Function(CallMadeResponse data) callback) {
    socket.on(SocketListenerEvents.CALL_MADE.path, ((data) {
      final response = CallMadeResponse.fromJson(data);

      return callback(response);
    }));
  }

  onAnswerMade(void Function(AnswerMadeResponse data) callback) {
    socket.on(SocketListenerEvents.ANSWER_MADE.path, ((data) {
      final response = AnswerMadeResponse.fromJson(data);

      return callback(response);
    }));
  }

  onMessageReceived(void Function(MessageReceivedResponse response) callback) {
    socket.on(SocketListenerEvents.MESSAGE_RECEIVED.path, ((data) {
      final response = MessageReceivedResponse.fromJson(data);

      return callback(response);
    }));
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

  onIceCandidate(void Function(OnIceCandidateResponse response) callback) {
    socket.on(SocketListenerEvents.RECEIVED_ICE_CANDIDATE.path, ((data) {
      final response = OnIceCandidateResponse.fromJson(data);

      return callback(response);
    }));
  }

  onClientDisconnected(VoidCallback callback) {
    socket.on(
        SocketListenerEvents.CLIENT_DISCONNECTED.path, ((data) => callback()));
  }
}
