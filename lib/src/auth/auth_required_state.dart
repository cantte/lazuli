import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/users/screens/user_sign_up_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRequiredState<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future _checkAuth() async {
    final session = await SupabaseAuth.instance.initialSession;
    if (session == null) {
      Get.to(() => const SignUpScreen());
    }
  }
}
