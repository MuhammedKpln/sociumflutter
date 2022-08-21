import 'package:flutter/foundation.dart';

enum ApiService {
  SupabaseUrl("https://yjifhdpnxmwbuaoxumbk.supabase.co"),
  WebsocketAPI(kDebugMode
      ? "https://9d69-213-65-65-28.eu.ngrok.io"
      : 'https://cio.derdevam.com');

  final String path;
  const ApiService(this.path);
}
