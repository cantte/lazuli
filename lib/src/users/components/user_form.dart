import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/users/user_service.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final service = Get.put(UserService());

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            emailField(),
            const SizedBox(height: 20.0),
            passwordField(),
            const SizedBox(height: 20.0),
            singUpButton(),
            Row(
              children: [
                Text('Already have an account?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.outline)),
                const SizedBox(width: 5),
                singInButton(),
              ],
            ),
          ],
        ));
  }

  Widget emailField() {
    return TextFormField(
      controller: email,
      decoration: const InputDecoration(
        labelText: 'Email',
        helperText: 'Please enter your email',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: password,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        helperText: 'Please enter a password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  Widget singUpButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 36),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await signUp(email.text, password.text);

          email.clear();
          password.clear();
        }
      },
      child: const Text('Sing up'),
    );
  }

  Widget singInButton() {
    return TextButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await signIn(email.text, password.text);

          email.clear();
          password.clear();
        }
      },
      child: const Text('Sing in'),
    );
  }

  Future<void> signUp(String email, String password) async {
    await service.signUp(email, password);
  }

  Future<void> signIn(String email, String password) async {
    return;
  }
}
