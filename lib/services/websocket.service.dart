import 'package:flutter/material.dart';
import 'package:scflutter/serivces.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketCore {
  late IO.Socket socket;

  SocketCore() {
    final uri = ApiService.WebsocketAPI.path;
    final options = IO.OptionBuilder().setTransports(["websocket"]).build();
    socket = IO.io(uri, options);

    socket.onConnect((data) {
      print(data);
    });
  }

  @protected
  emit(String event, {Map<String, dynamic>? data}) {
    socket.emit(event, data);
  }
}
