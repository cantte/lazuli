import 'package:flutter/material.dart';
import 'package:lazuli/src/products/components/register_product_form.dart';

class RegisterProductScreen extends StatelessWidget {
  const RegisterProductScreen({Key? key}) : super(key: key);

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
        'Register product',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget body() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: RegisterProductForm(),
    );
  }
}
