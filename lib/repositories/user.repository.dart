import 'package:flutter/foundation.dart';
import 'package:scflutter/repositories/_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user.dart';

class UserRepository extends BaseRepositoryClass {
  SupabaseQueryBuilder get _builder => supabase.from("users");

  Future<UserModel> updateProfile(
      Map<String, dynamic> data, String userId) async {
    try {
      final request = await _builder.update(data).eq("id", userId);
      final parsedData = UserModel.fromJson(request.data[0]);

      return parsedData;
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<UserModel> fetchUser(String username) async {
    try {
      final request = await _builder.select().eq("username", username).single();

      return UserModel.fromJson(request.data);
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<UserMetaData> fetchUserMeta(String userId) async {
    try {
      final fetchMetaData = await supabase.rpc('user_followers_count');
      return UserMetaData(
          followers: fetchMetaData.data[0],
          followings: fetchMetaData.data[1],
          rooms: fetchMetaData.data[2]);
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<String?> uploadAvatar(
      String filePath, Uint8List bytes, String userId) async {
    try {
      final request =
          await supabase.storage.from("users").uploadBinary(filePath, bytes);
      try {
        await updateProfile({"avatar": request}, userId);
      } catch (err) {
        logError(err);
        throw Exception(err);
      }

      return request;
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<bool> saveLocale(String locale, String userId) async {
    try {
      await _builder.update({"locale": locale}).eq("id", userId);
      return true;
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }
}
