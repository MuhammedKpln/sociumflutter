import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/repositories/auth.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user.dart';

part 'auth.state.freezed.dart';
part 'auth.state.g.dart';

@freezed
abstract class AuthStateModel with _$AuthStateModel {
  const factory AuthStateModel(
      {String? accessToken,
      String? refreshToken,
      User? rawUser,
      UserModel? user}) = _AuthStateModel;

  factory AuthStateModel.fromJson(Map<String, dynamic> json) =>
      _$AuthStateModelFromJson(json);
}

class UserModelNotifier extends StateNotifier<AuthStateModel> {
  UserModelNotifier()
      : super(const AuthStateModel(accessToken: null, user: null));

  setUser(AuthStateModel user) {
    state = user;
  }

  clearUser() async {
    await AuthRepository().signOut();
    state = const AuthStateModel();
  }
}

final userProvider =
    StateNotifierProvider<UserModelNotifier, AuthStateModel>((ref) {
  return UserModelNotifier();
});
