import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

import '../models/user.dart';

part 'auth.state.freezed.dart';
part 'auth.state.g.dart';

@freezed
abstract class AuthStateModel with _$AuthStateModel {
  const factory AuthStateModel(
      {String? accessToken,
      String? refreshToken,
      User? user}) = _AuthStateModel;

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
    await

        /// A singleton that is used to access the Supabase client.
        Supabase.instance.client.auth.signOut();
    state = const AuthStateModel();
  }
}

final userProvider =
    StateNotifierProvider<UserModelNotifier, AuthStateModel>((ref) {
  return UserModelNotifier();
});
