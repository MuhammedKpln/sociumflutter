import 'package:scflutter/models/login_response.model.dart';
import 'package:scflutter/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user.dart';

class AuthRepository with LoggerMixin {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<LoginResponse> signIn(
      {required String email, required String password}) async {
    final request =
        await _supabase.auth.signIn(email: email, password: password);

    if (request.session == null) {
      throw Exception(request.statusCode);
    }

    final userProfile = await getUserProfile(userUuid: request.user?.id ?? "");

    return LoginResponse(
        user: userProfile,
        rawUser: request.user!,
        accessToken: request.session!.accessToken,
        refreshToken: request.session!.refreshToken!);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<LoginResponse> signUp(
      {required String email,
      required String password,
      required String username}) async {
    final request = await _supabase.auth
        .signUp(email, password, userMetadata: {"username": username});

    if (request.session == null) {
      throw Exception(request.statusCode);
    }

    final userProfile = await getUserProfile(userUuid: request.user?.id ?? "");
    return LoginResponse(
        user: userProfile,
        rawUser: request.user!,
        accessToken: request.session!.accessToken,
        refreshToken: request.session!.refreshToken!);
  }

  Future<UserModel> getUserProfile({required String userUuid}) async {
    final request =
        await _supabase.from('users').select().eq('id', userUuid).single();

    if (request == null) {
      logError("No profile found with userId: $userUuid");
    }

    return UserModel.fromJson(request.data);
  }
}
