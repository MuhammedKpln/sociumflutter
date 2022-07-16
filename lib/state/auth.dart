import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/graphql/graphql_api.dart';
import 'package:scflutter/storage/auth.storage.dart';

class AuthStateModel {
  late String accessToken;
  late Login$Mutation$Login$User user;

  AuthStateModel({required this.accessToken, required this.user});
}

class UserModelNotifier extends StateNotifier<AuthStateModel> {
  UserModelNotifier()
      : super(
            AuthStateModel(accessToken: "", user: Login$Mutation$Login$User()));

  Future<void> setUser(AuthStateModel user) async {
    await saveLogin(user);

    state = user;
  }

  void clearUser() {
    deleteUser();

    state = AuthStateModel(accessToken: "", user: Login$Mutation$Login$User());
  }
}

final userProvider = StateNotifierProvider((ref) {
  return UserModelNotifier();
});
