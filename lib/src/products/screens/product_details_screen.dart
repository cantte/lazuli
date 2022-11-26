import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/products/components/product_details.dart';

import 'update_product_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String id;

  const ProductDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => UpdateProductScreen(id: id));
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return ProductDetails(id: id);
  }
}
