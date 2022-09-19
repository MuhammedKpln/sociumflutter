import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField()
  static const SUPABASE_URL = _Env.SUPABASE_URL;
  @EnviedField(obfuscate: true)
  static final SUPABASE_ANON_KEY = _Env.SUPABASE_ANON_KEY;
  @EnviedField()
  static const WEBSOCKET_API = _Env.WEBSOCKET_API;
}
