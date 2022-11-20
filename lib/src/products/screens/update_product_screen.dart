import 'package:flutter/material.dart';
import 'package:lazuli/src/products/components/update_product_form.dart';

class UpdateProductScreen extends StatelessWidget {
  final String id;

  const UpdateProductScreen({Key? key, required this.id}) : super(key: key);

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
        'Update product',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: UpdateProductForm(id: id),
    );
  }
}
