import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/products/models.dart';
import 'package:lazuli/src/products/service.dart';

class RegisterProductForm extends StatefulWidget {
  const RegisterProductForm({Key? key}) : super(key: key);

  @override
  State<RegisterProductForm> createState() => _RegisterProductFormState();
}

class _RegisterProductFormState extends State<RegisterProductForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final service = Get.put(ProductService());

  final loading = false.obs;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(children: <Widget>[
          idField(),
          const SizedBox(
            height: 20.0,
          ),
          nameField(),
          const SizedBox(
            height: 20.0,
          ),
          descriptionField(),
          const SizedBox(
            height: 20.0,
          ),
          priceField(),
          const SizedBox(
            height: 20.0,
          ),
          quantityField(),
          const SizedBox(
            height: 20.0,
          ),
          submitButton(),
        ]));
  }

  Widget idField() {
    return FormBuilderTextField(
      name: 'id',
      decoration: const InputDecoration(
        labelText: 'Id',
        helperText: 'Please enter a product id',
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(50)
      ]),
    );
  }

  Widget nameField() {
    return FormBuilderTextField(
      name: 'name',
      decoration: const InputDecoration(
        labelText: 'Name',
        helperText: 'Please enter a product name',
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(50)
      ]),
    );
  }

  Widget descriptionField() {
    return FormBuilderTextField(
      name: 'description',
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
      decoration: const InputDecoration(
        labelText: 'Description',
        helperText: 'Please enter a product description',
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(250)
      ]),
    );
  }

  Widget priceField() {
    return FormBuilderTextField(
        name: 'price',
        decoration: const InputDecoration(
          labelText: 'Price',
          helperText: 'Please enter a product price',
        ),
        keyboardType: TextInputType.number,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.numeric(),
          FormBuilderValidators.min(1)
        ]));
  }

  Widget quantityField() {
    return FormBuilderTextField(
        name: 'quantity',
        decoration: const InputDecoration(
          labelText: 'Quantity',
          helperText: 'Please enter a product quantity',
        ),
        keyboardType: TextInputType.number,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.numeric(),
          FormBuilderValidators.min(1)
        ]));
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
        final product = Product.fromForm(_formKey.currentState!.value);

        await service.create(product);

        _formKey.currentState?.reset();
      } catch (e) {
        log(e.toString());
      } finally {
        loading.trigger(false);
      }
    }
  }
}
