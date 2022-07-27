// ignore_for_file: constant_identifier_names

import 'package:scflutter/extensions/eventEmitter.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:scflutter/services/websocket.service.dart';

import '../models/socket/message_received_response.dart';
import '../models/socket/send_message_arguments.dart';

enum SocketFireEvents {
  JoinQueue("join queue"),
  JoinRoom("join room"),
  LeaveQueue("leave queue"),
  SendMessage("send message");

  final String path;
  const SocketFireEvents(this.path);
}

enum SocketListenerEvents {
  CLIENT_PAIRED("CLIENT_PAIRED"),
  MESSAGE_RECEIVED("MESSAGE_RECEIVED");

  final String path;
  const SocketListenerEvents(this.path);
}

class SocketService extends SocketCore {
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

  onMessageReceived(void Function(MessageReceivedResponse response) callback) {
    eventEmitter.on(SocketListenerEvents.MESSAGE_RECEIVED.path, null,
        ((ev, context) {
      final mappedData = ev.toMap();
      final response = MessageReceivedResponse.fromJson(mappedData["data"]);

      return callback(response);
    }));
  }
}
