import 'package:flutter/material.dart';
import 'package:lazuli/src/users/components/user_form.dart';

class UserSignUpScreen extends StatelessWidget {
  const UserSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Stack(
      children: <Widget>[
        Column(children: <Widget>[header(context), body()]),
      ],
    ));
  }

  Widget header(BuildContext context) {
    return Center(
      child: Text(
        'Sing up',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget body() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: UserForm(),
    );
  }
}
