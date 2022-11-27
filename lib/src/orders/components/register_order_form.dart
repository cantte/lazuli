import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/auth/auth_required_state.dart';
import 'package:lazuli/src/orders/models.dart';
import 'package:lazuli/src/orders/service.dart';
import 'package:lazuli/src/products/models.dart';

class RegisterOrderForm extends StatefulWidget {
  const RegisterOrderForm({Key? key}) : super(key: key);

  @override
  State<RegisterOrderForm> createState() => _RegisterOrderFormState();
}

class _RegisterOrderFormState extends AuthRequiredState<RegisterOrderForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final service = Get.put(OrderService());

  final loading = false.obs;

  final selectedProducts = <Product>[].obs;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(children: [
          customerNameField(),
          const SizedBox(
            height: 20.0,
          ),
          customerAddressField(),
          const SizedBox(
            height: 20.0,
          ),
          customerPhoneField(),
          const SizedBox(
            height: 20.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            addProductButton(),
          ]),
          const SizedBox(
            height: 20.0,
          ),
          Obx(() => Column(
                children: selectedProducts
                    .map((product) => productRow(product))
                    .toList(),
              )),
          submitButton(),
        ]));
  }

  Widget customerNameField() {
    return FormBuilderTextField(
      name: 'customer_name',
      decoration: const InputDecoration(labelText: 'Customer name'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(50),
      ]),
    );
  }

  Widget customerAddressField() {
    return FormBuilderTextField(
      name: 'customer_address',
      decoration: const InputDecoration(labelText: 'Customer address'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(150),
      ]),
    );
  }

  Widget customerPhoneField() {
    return FormBuilderTextField(
      name: 'customer_phone',
      decoration: const InputDecoration(labelText: 'Customer phone'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(30),
      ]),
    );
  }

  Widget addProductButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        // Foreground color
        // ignore: deprecated_member_use
        onPrimary: Theme.of(context).colorScheme.onSecondaryContainer,
        // Background color
        // ignore: deprecated_member_use
        primary: Theme.of(context).colorScheme.secondaryContainer,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      onPressed: () {},
      label: const Text('Add product'),
      icon: const Icon(Icons.add),
    );
  }

  Widget productRow(Product product) {
    return Row(
      children: [
        Expanded(
          child: Text(product.name),
        ),
        Text(product.price.toString()),
        IconButton(
          onPressed: () {
            selectedProducts.remove(product);
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  Widget submitButton() {
    return Obx(() => ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 36),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          onPressed: loading.isTrue ? null : () async => await onSubmit(),
          child: const Text('Submit'),
        ));
  }

  Future onSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      loading.trigger(true);

      try {
        final order = Order.fromForm(_formKey.currentState!.value);

        await service.create(order);

        Get.back();
      } catch (e) {
        Get.snackbar('Error', e.toString());
      } finally {
        loading.trigger(false);
      }
    }
  }
}
