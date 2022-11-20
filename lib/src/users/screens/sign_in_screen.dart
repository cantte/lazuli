import 'package:flutter/material.dart';
import 'package:lazuli/src/users/components/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
              child: Stack(
            children: <Widget>[
              Column(children: <Widget>[header(context), body()]),
            ],
          )),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Center(
      child: Text(
        'Sign in',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget body() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: SignInForm(),
    );
  }
}
