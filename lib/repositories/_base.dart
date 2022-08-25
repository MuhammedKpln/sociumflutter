import 'package:scflutter/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BaseRepositoryClass with LoggerMixin {
  final SupabaseClient supabase = Supabase.instance.client;
}
