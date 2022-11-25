import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/auth/auth_required_state.dart';
import 'package:lazuli/src/products/models.dart';
import 'package:lazuli/src/products/service.dart';

class UpdateProductForm extends StatefulWidget {
  final String id;

  const UpdateProductForm({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateProductForm> createState() => _UpdateProductFormState();
}

class _UpdateProductFormState extends AuthRequiredState<UpdateProductForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final service = Get.put(ProductService());

  final loading = false.obs;

  @override
  void initState() {
    super.initState();
    loadProduct().then((value) => null);
  }

  Future loadProduct() async {
    loading.trigger(true);

    final product = await service.find(widget.id);

    _formKey.currentState?.patchValue(product.toForm());

    loading.trigger(false);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text("Code: ${widget.id}"),
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
          ],
        ));
  }

  Widget idField() {
    // Hide the id field
    return FormBuilderField(
      name: 'id',
      enabled: false,
      builder: (FormFieldState<dynamic> field) {
        return Container();
      },
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
          child: const Text('Update'),
        ));
  }

  Future onSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      loading.trigger(true);

      // Set the product id
      _formKey.currentState?.fields['id']?.didChange(widget.id);

      try {
        final product = Product.fromForm(_formKey.currentState!.value);

        await service.update(product);
      } catch (e) {
        log(e.toString());
      } finally {
        loading.trigger(false);
      }
    }
  }
}
