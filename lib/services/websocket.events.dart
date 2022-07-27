// ignore_for_file: constant_identifier_names

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:scflutter/extensions/eventEmitter.dart';
import 'package:scflutter/models/socket/answer_made_response.dart';
import 'package:scflutter/models/socket/call_made_response.dart';
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
  SendMessage("send message");

  final String path;
  const SocketFireEvents(this.path);
}

enum SocketListenerEvents {
  CLIENT_PAIRED("CLIENT_PAIRED"),
  MESSAGE_RECEIVED("MESSAGE_RECEIVED"),
  CALL_MADE("CALL_MADE"),
  RECEIVED_ICE_CANDIDATE("RECEIVED_ICE_CANDIDATE"),
  ANSWER_MADE('ANSWER_MADE');

  final String path;
  const SocketListenerEvents(this.path);
}

class SocketService extends SocketCore {
  callUser(RTCSessionDescription offer, String userUUID) {
    emit(SocketFireEvents.CallUser.path,
        data: {"offer": offer.toMap(), "uuid": userUUID});
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

  onClientPaired(void Function(dynamic data) callback) {
    eventEmitter.on(SocketListenerEvents.CLIENT_PAIRED.path, null,
        ((ev, context) => callback(ev.eventData)));
  }

  onCallMade(void Function(CallMadeResponse data) callback) {
    eventEmitter.on(SocketListenerEvents.CALL_MADE.path, null, ((ev, context) {
      final mappedData = ev.toMap();
      final response = CallMadeResponse.fromJson(mappedData["data"]);

      return callback(response);
    }));
  }

  onAnswerMade(void Function(AnswerMadeResponse data) callback) {
    eventEmitter.on(SocketListenerEvents.ANSWER_MADE.path, null,
        ((ev, context) {
      final mappedData = ev.toMap();
      final response = AnswerMadeResponse.fromJson(mappedData["data"]);

      return callback(response);
    }));
  }

  onMessageReceived(void Function(MessageReceivedResponse response) callback) {
    eventEmitter.on(SocketListenerEvents.MESSAGE_RECEIVED.path, null,
        ((ev, context) {
      final mappedData = ev.toMap();
      final response = MessageReceivedResponse.fromJson(mappedData["data"]);

      return callback(response);
    }));
  }

  onIceCandidate(void Function(OnIceCandidateResponse response) callback) {
    eventEmitter.on(SocketListenerEvents.RECEIVED_ICE_CANDIDATE.path, null,
        ((ev, context) {
      final mappedData = ev.toMap();
      final response = OnIceCandidateResponse.fromJson(mappedData["data"]);

      return callback(response);
    }));
  }
}
