import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'follower.freezed.dart';
part 'follower.g.dart';

@freezed
class FollowerRepositoryOutput with _$FollowerRepositoryOutput {
  factory FollowerRepositoryOutput(
      {required int followers,
      required int followings}) = _FollowerRepositoryOutput;
}

@freezed
class Follower with _$Follower {
  factory Follower(
      {required int id,
      required String user,
      required String actor,
      User? user_data,
      User? actor_data,
      required DateTime created_at}) = _Follower;

  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);
}
