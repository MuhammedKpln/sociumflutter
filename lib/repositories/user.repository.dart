import 'package:scflutter/repositories/_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository extends BaseRepositoryClass {
  SupabaseQueryBuilder get _builder => supabase.from("users");

  Future<String> editBio(String newBio, String userId) async {
    try {
      final request = await _builder
          .update({"biography": newBio})
          .eq("id", userId)
          .execute();

      return Future.value(request.data["biography"]);
    } catch (err) {
      logError(err);
      throw Exception(err);
    }
  }
}
