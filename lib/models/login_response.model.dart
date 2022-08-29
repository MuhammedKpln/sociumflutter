import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_response.model.freezed.dart';
part 'login_response.model.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  factory LoginResponse({
    required UserModel user,
    required User rawUser,
    required String accessToken,
    required String refreshToken,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
