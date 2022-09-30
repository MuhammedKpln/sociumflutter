import 'package:scflutter/repositories/_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FcmRepository extends BaseRepositoryClass {
  SupabaseQueryBuilder get _builder => supabase.from("fcm_token");

  Future<void> updateFcmToken(
      {required String fcmToken, required String user}) async {
    await _builder.upsert({"fcm_token": fcmToken, "user": user}).execute();
  }
}
