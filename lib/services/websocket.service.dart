import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scflutter/serivces.dart';
import 'package:scflutter/utils/logger.dart';
import 'package:web_socket_channel/io.dart';
import 'package:eventify/eventify.dart' as eventify;

class SocketCore {
  late IOWebSocketChannel socket;
  eventify.EventEmitter eventEmitter = eventify.EventEmitter();

  SocketCore() {
    socket =
        IOWebSocketChannel.connect(Uri.parse(ApiService.WebsocketAPI.path));
    _listen();
  }

  @protected
  emit(String event, {Map<String, dynamic>? data}) {
    final mappedData = {"event": event, "data": data};
    final encodedData = json.encode(mappedData);

    socket.sink.add(encodedData);
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
        Logger().error(e);
      }
    });
  }
}
