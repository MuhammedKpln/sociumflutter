// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum ApiService {
  GraphQLAPI(kDebugMode
      ? "http://localhost:3000/graphql"
      : 'https://derdevam.com/graphql'),
  WebsocketAPI(
      kDebugMode ? "http://localhost:3001" : 'https://cio.derdevam.com');

  final String path;
  const ApiService(this.path);
}
