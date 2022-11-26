import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:lazuli/src/orders/models.dart';
import 'package:lazuli/src/orders/service.dart';

class RegisterOrderForm extends StatefulWidget {
  const RegisterOrderForm({Key? key}) : super(key: key);

  @override
  State<RegisterOrderForm> createState() => _RegisterOrderFormState();
}

class _RegisterOrderFormState extends State<RegisterOrderForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final service = Get.put(OrderService());

  final loading = false.obs;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(children: [
          const SizedBox(
            height: 20.0,
          ),
          submitButton(),
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
