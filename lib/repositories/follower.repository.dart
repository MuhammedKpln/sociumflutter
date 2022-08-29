import 'package:scflutter/models/follower.dart';
import 'package:scflutter/repositories/_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FollowerRepository extends BaseRepositoryClass {
  SupabaseQueryBuilder get _builder => supabase.from("followers");

  FollowerRepository()
      : super(BaseRepositoryArguments(userData: true, actorData: true));

  Future<FollowerRepositoryOutput> fetchFollowingsCount(String userId) async {
    final fetchFollowings =
        await supabase.rpc('user_followers_count').execute();

    if (!fetchFollowings.hasError) {
      return FollowerRepositoryOutput(
          followers: fetchFollowings.data[0],
          followings: fetchFollowings.data[1]);
    }

    logError(fetchFollowings.error);
    throw Exception(fetchFollowings.error);
  }

  Future<List<Follower>> fetchUserFollowers(String userId) async {
    String select = userMeta.join(",");
    final request = await _builder.select(select).eq('actor', userId).execute();

    if (!request.hasError) {
      return List<Follower>.from(
          request.data.map((data) => Follower.fromJson(data)));
    }

    logError(request.error);
    throw Exception(request.error);
  }

  Future<List<Follower>> fetchUserFollowings(String userId) async {
    String select = userMeta.join(",");
    final request = await _builder.select(select).eq('user', userId).execute();

    if (!request.hasError) {
      return List<Follower>.from(
          request.data.map((data) => Follower.fromJson(data)));
    }

    logError(request.error);
    throw Exception(request.error);
  }
}
