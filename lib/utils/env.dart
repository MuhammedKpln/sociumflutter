import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(obfuscate: true)
  static const SUPABASE_URL = _Env.SUPABASE_URL;
  @EnviedField(obfuscate: true)
  static const SUPABASE_ANON_KEY = _Env.SUPABASE_ANON_KEY;
  @EnviedField(obfuscate: true)
  static const WEBSOCKET_API = _Env.WEBSOCKET_API;
}
