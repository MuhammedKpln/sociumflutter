import 'package:scflutter/models/login_response.model.dart';
import 'package:scflutter/repositories/_base.dart';

import '../models/user.dart';

class AuthRepository extends BaseRepositoryClass {
  Future<LoginResponse> signIn(
      {required String email, required String password}) async {
    try {
      final request =
          await supabase.auth.signIn(email: email, password: password);

      final userProfile =
          await getUserProfile(userUuid: request.user?.id ?? "");

      return LoginResponse(
          user: userProfile,
          rawUser: request.user!,
          accessToken: request.session!.accessToken,
          refreshToken: request.session!.refreshToken!);
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<LoginResponse> signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final request = await supabase.auth
          .signUp(email, password, userMetadata: {"username": username});

      final userProfile =
          await getUserProfile(userUuid: request.user?.id ?? "");

      return LoginResponse(
          user: userProfile,
          rawUser: request.user!,
          accessToken: request.session!.accessToken,
          refreshToken: request.session!.refreshToken!);
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<UserModel> getUserProfile({required String userUuid}) async {
    try {
      final request =
          await supabase.from('users').select().eq('id', userUuid).single();

      return UserModel.fromJson(request);
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }
}
