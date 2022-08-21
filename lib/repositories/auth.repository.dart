import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<GotrueSessionResponse> signIn(
      {required String email, required String password}) async {
    final request =
        await _supabase.auth.signIn(email: email, password: password);

    if (request.error != null) {
      throw Exception(request.error);
    }

    return request;
  }

  signOut() async {
    final request = await _supabase.auth.signOut();

    if (request.error != null) {
      throw Exception(request.error);
    }
  }

  Future<GotrueSessionResponse> signUp(
      {required String email,
      required String password,
      required String username}) async {
    final request = await _supabase.auth
        .signUp(email, password, userMetadata: {"username": username});

    if (request.error != null) {
      throw Exception(request.error);
    }

    return request;
  }
}
