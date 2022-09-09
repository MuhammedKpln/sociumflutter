import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/models/user.dart';

part 'follower.freezed.dart';
part 'follower.g.dart';

@freezed
class Follower with _$Follower {
  factory Follower(
      {required int id,
      required String user,
      required String actor,
      UserModel? user_data,
      UserModel? actor_data,
      required DateTime created_at}) = _Follower;

  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);
}
