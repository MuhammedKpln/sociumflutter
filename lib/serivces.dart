// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:scflutter/utils/env.dart';

enum ApiService {
  SupabaseUrl(Env.SUPABASE_URL),
  WebsocketAPI(kDebugMode
      ? "https://dad4-78-82-129-164.eu.ngrok.io"
      : Env.WEBSOCKET_API);

  final String path;
  const ApiService(this.path);
}
