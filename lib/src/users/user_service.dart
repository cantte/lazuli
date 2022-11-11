library users;

import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final client = Supabase.instance.client;

  Future<void> signUp(String email, String password) async {
    await client.auth.signUp(email: email, password: password);
  }
}
