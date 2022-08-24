import 'package:flutter/foundation.dart';

enum ApiService {
  SupabaseUrl("https://yjifhdpnxmwbuaoxumbk.supabase.co"),
  WebsocketAPI(kDebugMode
      ? "https://e7ae-78-82-129-164.eu.ngrok.io"
      : 'https://socium.fly.dev');

  final String path;
  const ApiService(this.path);
}
