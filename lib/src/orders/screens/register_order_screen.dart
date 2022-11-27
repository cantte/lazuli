import 'package:flutter/material.dart';
import 'package:lazuli/src/orders/components/register_order_form.dart';

class RegisterOrderScreen extends StatelessWidget {
  const RegisterOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
        'Register order',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget body() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: RegisterOrderForm(),
    );
  }
}
