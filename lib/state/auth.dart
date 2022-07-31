import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:scflutter/storage/auth.storage.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

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

  setUser(AuthStateModel user) async {
    await saveLogin(user);

    state = user;
  }

  setBio(String bio) async {
    final authModel = state.copyWith(user: state.user?.copyWith(bio: bio));
    await saveLogin(authModel);
    state = authModel;
  }

  setBirthday(DateTime birthday) async {
    final authModel =
        state.copyWith(user: state.user?.copyWith(birthday: birthday));
    await saveLogin(authModel);
    state = authModel;
  }

  setBlockIncomingCalls(bool blockIncomingCalls) async {
    final authModel = state.copyWith(
        user: state.user?.copyWith(blockIncomingCalls: blockIncomingCalls));
    await saveLogin(authModel);
    state = authModel;
  }

  clearUser() async {
    await deleteUser();
    state = const AuthStateModel();
  }
}

final userProvider =
    StateNotifierProvider<UserModelNotifier, AuthStateModel>((ref) {
  return UserModelNotifier();
});
