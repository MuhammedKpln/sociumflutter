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

    if (request.error != null) {
      throw Exception(request.error);
    }

    final userProfile =
        await getUserProfile(userUuid: request.data?.user?.id ?? "");

    return LoginResponse(
        user: userProfile,
        rawUser: request.data!.user!,
        accessToken: request.data!.accessToken,
        refreshToken: request.data!.refreshToken!);
  }

  Future<void> signOut() async {
    final request = await _supabase.auth.signOut();

    if (request.error != null) {
      throw Exception(request.error);
    }
  }

  Future<LoginResponse> signUp(
      {required String email,
      required String password,
      required String username}) async {
    final request = await _supabase.auth
        .signUp(email, password, userMetadata: {"username": username});

    if (request.error != null) {
      throw Exception(request.error);
    }

    final userProfile =
        await getUserProfile(userUuid: request.data?.user?.id ?? "");

    return LoginResponse(
        user: userProfile,
        rawUser: request.data!.user!,
        accessToken: request.data!.accessToken,
        refreshToken: request.data!.refreshToken!);
  }

  Future<UserModel> getUserProfile({required String userUuid}) async {
    final request = await _supabase
        .from('users')
        .select()
        .eq('id', userUuid)
        .single()
        .execute();

    if (request.hasError) {
      logError(request.error);
    }

    return UserModel.fromJson(request.data);
  }
}
