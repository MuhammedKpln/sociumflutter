import 'package:scflutter/config.dart';
import 'package:scflutter/serivces.dart';
import 'package:supabase/supabase.dart';

class SupabaseService {
  final SupabaseClient _client = SupabaseClient(
      ApiService.SupabaseUrl.path, Config.SupabaseAnonKey,
      autoRefreshToken: true);

  SupabaseClient get client => _client;
}
