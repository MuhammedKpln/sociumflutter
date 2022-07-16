import 'dart:convert';

import 'package:scflutter/graphql/graphql_api.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as wsStatus;
import 'package:eventify/eventify.dart';

class SocketFireEvents {
  static final JoinQueue = "join queue";
  static final LeaveQueue = "leave queue";
}

class SocketListenerEvents {
  static final CLIENT_PAIRED = "CLIENT_PAIRED";
}

class Socket {
  late IOWebSocketChannel socket;
  EventEmitter eventEmitter = EventEmitter();

  Socket() {
    socket = IOWebSocketChannel.connect(Uri.parse('ws://localhost:3001'));
    _listen();
  }

  _emit(String event, {Object? data}) {
    final _data = {"event": event, "data": data};
    final encodedData = json.encode(_data);

    socket.sink.add(encodedData);
  }

  joinQueue(Login$Mutation$Login$User user) {
    _emit(SocketFireEvents.JoinQueue, data: {"user": user.toJson()});
  }

  leaveQueue() {
    _emit(SocketFireEvents.LeaveQueue);
  }

  onClientPaired(void Function(dynamic data) callback) {
    eventEmitter.on(SocketListenerEvents.CLIENT_PAIRED, null,
        ((ev, context) => callback(ev.eventData)));
  }

  _listen() {
    socket.stream.listen((message) {
      try {
        final parsedMessage = json.decode(message);
        final eventName = parsedMessage["event"];
        final eventData = parsedMessage["data"];
        if (eventName != null && eventData != null) {
          eventEmitter.emit(eventName, null, eventData);
        }
      } catch (e) {
        print(e);
      }
    });
  }

  send() {
    socket.sink.add(json.encode({"event": "ping"}));
  }
}
