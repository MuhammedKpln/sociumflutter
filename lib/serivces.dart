// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:scflutter/utils/env.dart';

enum ApiService {
  SupabaseUrl(Env.SUPABASE_URL),
  WebsocketAPI(kDebugMode ? Env.WEBSOCKET_API : Env.WEBSOCKET_API);

  final String path;
  const ApiService(this.path);
}
