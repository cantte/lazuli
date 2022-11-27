import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/orders/models.dart';
import 'package:lazuli/src/products/models.dart';
import 'package:lazuli/src/products/service.dart';

class RegisterOrderItemForm extends StatefulWidget {
  final Function(OrderItem) onSubmit;

  const RegisterOrderItemForm({Key? key, required this.onSubmit})
      : super(key: key);

  @override
  State<RegisterOrderItemForm> createState() => _RegisterOrderItemFormState();
}

class _RegisterOrderItemFormState extends State<RegisterOrderItemForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  final productService = Get.put(ProductService());

  final loading = false.obs;

  final products = <Product>[].obs;

  late Function(OrderItem) onSubmit = widget.onSubmit;

  @override
  void initState() {
    super.initState();

    _loadProducts();
  }

  Future _loadProducts() async {
    loading.trigger(true);

    final products = await productService.searchAll();
    this.products.addAll(products);

    loading.trigger(false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add product'),
      content: SingleChildScrollView(
          child: FormBuilder(
              key: _formKey,
              child: Column(children: [
                productField(),
                const SizedBox(height: 20.0),
                quantityField()
              ]))),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        TextButton(onPressed: () => _submit(), child: const Text('Add product'))
      ],
    );
  }

  Widget productField() {
    return Obx(() => FormBuilderDropdown(
          name: 'product',
          decoration: const InputDecoration(labelText: 'Product'),
          validator: FormBuilderValidators.required(),
          items: products
              .map((product) => DropdownMenuItem(
                    value: product,
                    child: Text('${product.name}, \$${product.price}'),
                  ))
              .toList(),
        ));
  }

  Widget quantityField() {
    return FormBuilderTextField(
      name: 'quantity',
      decoration: const InputDecoration(labelText: 'Quantity'),
      keyboardType: TextInputType.number,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.numeric(),
        FormBuilderValidators.min(1)
      ]),
    );
  }

  void _submit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final orderItem = OrderItem.fromForm(_formKey.currentState!.value);

      onSubmit(orderItem);

      Get.back();
    }
  }
}
