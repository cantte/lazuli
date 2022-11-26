import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/auth/auth_required_state.dart';
import 'package:lazuli/src/products/models.dart';
import 'package:lazuli/src/products/service.dart';

class ProductDetails extends StatefulWidget {
  final String id;

  const ProductDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends AuthRequiredState<ProductDetails> {
  final service = Get.put(ProductService());

  final loading = false.obs;
  late Product product;

  @override
  void initState() {
    super.initState();
    loadProduct().then((value) => null);
  }

  Future loadProduct() async {
    loading.trigger(true);

    product = await service.find(widget.id);

    loading.trigger(false);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => loading.isTrue
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            children: [
              ListTile(
                title: const Text('Id'),
                subtitle: Text(product.id),
              ),
              ListTile(
                title: const Text('Name'),
                subtitle: Text(product.name),
              ),
              ListTile(
                title: const Text('Description'),
                subtitle: Text(product.description),
              ),
              ListTile(
                title: const Text('Price'),
                subtitle: Text(product.price.toString()),
              ),
              ListTile(
                title: const Text('Quantity'),
                subtitle: Text(product.quantity.toString()),
              ),
            ],
          ));
  }
}
