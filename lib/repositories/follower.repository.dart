import 'package:scflutter/models/follower.dart';
import 'package:scflutter/repositories/_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FollowerRepository extends BaseRepositoryClass {
  SupabaseQueryBuilder get _builder => supabase.from("followers");

  FollowerRepository()
      : super(BaseRepositoryArguments(userData: true, actorData: true));

  Future<List<Follower>> fetchUserFollowers(String userId) async {
    try {
      final request = await _builder.select(selectUserMeta).eq('actor', userId);
      return List<Follower>.from(
          request.data.map((data) => Follower.fromJson(data)));
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<List<Follower>> fetchUserFollowings(String userId) async {
    try {
      final request = await _builder.select(selectUserMeta).eq('user', userId);

      return List<Follower>.from(
          request.data.map((data) => Follower.fromJson(data)));
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }
}
