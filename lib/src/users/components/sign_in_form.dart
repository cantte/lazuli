import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/users/screens/user_sign_up_screen.dart';
import 'package:lazuli/src/users/user_service.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final service = Get.put(UserService());

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          emailField(),
          const SizedBox(
            height: 20.0,
          ),
          passwordField(),
          const SizedBox(
            height: 20.0,
          ),
          signInButton(),
          Row(children: <Widget>[
            Text('Don\'t have an account?',
                style: TextStyle(color: Theme.of(context).colorScheme.outline)),
            const SizedBox(
              width: 5,
            ),
            signUpButton(),
          ])
        ]));
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

  Widget signInButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 36),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await service.signIn(email.text, password.text);
        }
      },
      child: const Text('Sign In'),
    );
  }

  Widget signUpButton() {
    return TextButton(
      onPressed: () {
        Get.to(() => const SignUpScreen());
      },
      child: const Text('Sign Up'),
    );
  }
}
