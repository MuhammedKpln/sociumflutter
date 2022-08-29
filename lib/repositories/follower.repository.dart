import 'package:scflutter/models/follower.dart';
import 'package:scflutter/repositories/_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FollowerRepository extends BaseRepositoryClass {
  SupabaseQueryBuilder get _builder => supabase.from("followers");

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
}
