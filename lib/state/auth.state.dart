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

  setBiography(String bio) {
    final modifiedUser = state.user?.copyWith(biography: bio);

    state = state.copyWith(user: modifiedUser);
  }

  setBirthday(DateTime birthday) {
    final modifiedUser = state.user?.copyWith(birthday: birthday);

    state = state.copyWith(user: modifiedUser);
  }

  setBlockIncomingCalls(bool blockIncomingCalls) {
    final modifiedUser =
        state.user?.copyWith(blockIncomingCalls: blockIncomingCalls);

    state = state.copyWith(user: modifiedUser);
  }

  setAvatar(String avatarPath) {
    final modifiedUser = state.user?.copyWith(avatar: avatarPath);

    state = state.copyWith(user: modifiedUser);
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
