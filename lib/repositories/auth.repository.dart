import 'dart:async';

import 'package:scflutter/models/login_response.model.dart';
import 'package:scflutter/repositories/_base.dart';

import '../models/user.dart';

class AuthRepository extends BaseRepositoryClass {
  Future<LoginResponse?> signIn(
      {required String email, required String password}) async {
    try {
      final request =
          await supabase.auth.signIn(email: email, password: password);

      if (request.session == null) {
        throw Exception(request.statusCode);
      }

      final userProfile =
          await getUserProfile(userUuid: request.user?.id ?? "");

      return LoginResponse(
          user: userProfile!,
          rawUser: request.user!,
          accessToken: request.session!.accessToken,
          refreshToken: request.session!.refreshToken!);
    } catch (err) {
      logError(err);
      return null;
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<LoginResponse?> signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final request = await supabase.auth
          .signUp(email, password, userMetadata: {"username": username});

      final userProfile =
          await getUserProfile(userUuid: request.user?.id ?? "");

      return LoginResponse(
          user: userProfile!,
          rawUser: request.user!,
          accessToken: request.session!.accessToken,
          refreshToken: request.session!.refreshToken!);
    } catch (err) {
      logError(err);
      return null;
    }
  }

  Future<UserModel?> getUserProfile({required String userUuid}) async {
    try {
      final request =
          await supabase.from('users').select().eq('id', userUuid).single();

      if (request == null) {
        logError("No profile found with userId: $userUuid");
      }

      return UserModel.fromJson(request.data);
    } catch (err) {
      logError(err);
      return null;
    }
  }
}
