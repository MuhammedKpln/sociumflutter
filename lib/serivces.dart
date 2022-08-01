import 'package:flutter/foundation.dart';

enum ApiService {
  GraphQLAPI(kDebugMode
      ? "http://localhost:3000/graphql"
      : 'https://derdevam.com/graphql'),
  WebsocketAPI(kDebugMode ? "http://localhost:3001" : 'wss://cio.derdevam.com');

  final String path;
  const ApiService(this.path);
}
