import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lazuli/src/config/supabase.dart';
import 'package:lazuli/src/users/screens/user_sign_up_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'color_schemes.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: SupabaseConfig.url, anonKey: SupabaseConfig.annonKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        inputDecorationTheme:
            const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        inputDecorationTheme:
            const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      home: const Scaffold(
        body: SafeArea(child: Center(heightFactor: 10, child: SignUpScreen())),
      ),
    );
  }
}
