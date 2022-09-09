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

  Future<UserModel> fetchUser(String username) async {
    final request =
        await _builder.select().eq("username", username).single().execute();

    if (request.hasError) {
      logError(request.error);
      throw Exception(request.error);
    }

    return UserModel.fromJson(request.data);
  }

  Future<UserMetaData> fetchUserMeta(String userId) async {
    final fetchMetaData = await supabase.rpc('user_followers_count').execute();

    if (!fetchMetaData.hasError) {
      return UserMetaData(
          followers: fetchMetaData.data[0],
          followings: fetchMetaData.data[1],
          rooms: fetchMetaData.data[2]);
    }

    logError(fetchMetaData.error);
    throw Exception(fetchMetaData.error);
  }
}
