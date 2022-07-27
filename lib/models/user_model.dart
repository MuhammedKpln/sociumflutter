import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    String? username,
    double? id,
    String? email,
    double? gender,
    String? avatar,
    String? bio,
    bool? isEmailConfirmed,
    DateTime? birthday,
    bool? blockIncomingCalls,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
