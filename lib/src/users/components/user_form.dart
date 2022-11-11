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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              emailField(),
              passwordField(),
              const SizedBox(height: 20.0),
              submitButton(),
            ],
          ),
        ));
  }

  Widget emailField() {
    return TextFormField(
      controller: email,
      decoration: const InputDecoration(
        labelText: 'Email',
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
      decoration: const InputDecoration(
        labelText: 'Password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await signUp(email.text, password.text);

          email.clear();
          password.clear();
        }
      },
      child: const Text('Submit'),
    );
  }

  Future<void> signUp(String email, String password) async {
    await service.signUp(email, password);
  }
}
