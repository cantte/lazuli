import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/products/models.dart';
import 'package:lazuli/src/products/service.dart';
import 'package:logging/logging.dart';

class RegisterProductForm extends StatefulWidget {
  const RegisterProductForm({Key? key}) : super(key: key);

  @override
  State<RegisterProductForm> createState() => _RegisterProductFormState();
}

class _RegisterProductFormState extends State<RegisterProductForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final service = Get.put(ProductService());
  final log = Logger('RegisterProductForm');

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
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(50)
      ]),
    );
  }

  Widget nameField() {
    return FormBuilderTextField(
      name: 'name',
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(50)
      ]),
    );
  }

  Widget descriptionField() {
    return FormBuilderTextField(
      name: 'description',
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(250)
      ]),
    );
  }

  Widget priceField() {
    return FormBuilderTextField(
        name: 'price',
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
        final product = Product.fromJson(_formKey.currentState!.value);

        await service.create(product);

        _formKey.currentState?.reset();
      } catch (e) {
        log.severe(e);
      } finally {
        loading.trigger(false);
      }
    }
  }
}
