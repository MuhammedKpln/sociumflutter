import 'package:scflutter/repositories/_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user.dart';

class UserRepository extends BaseRepositoryClass {
  SupabaseQueryBuilder get _builder => supabase.from("users");

  Future<UserModel> updateProfile(
      Map<String, dynamic> data, String userId) async {
    final request = await _builder.update(data).eq("id", userId).execute();

    if (!request.hasError) {
      final parsedData = UserModel.fromJson(request.data[0]);

      return parsedData;
    }

    logError(request.error);
    throw Exception(request.error);
  }
}
