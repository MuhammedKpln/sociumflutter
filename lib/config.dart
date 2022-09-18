import 'package:scflutter/utils/env.dart';

class Config {
  static DateTime maximumDateForRegistration =
      DateTime(DateTime.now().year - 18, 1, 1);
  static DateTime minimumDateForRegistration = DateTime(1980);
  static const String SupabaseAnonKey = Env.SUPABASE_ANON_KEY;
}
