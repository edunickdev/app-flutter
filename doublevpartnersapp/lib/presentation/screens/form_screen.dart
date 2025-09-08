import 'package:doublevpartnersapp/presentation/components/custom_appbar_widget.dart';
import 'package:doublevpartnersapp/presentation/components/custom_button_widget.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

    void onPressed() {
      if (key.currentState!.validate()) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Procesando datos')));
      }
    }

    return Scaffold(
      appBar: HomeAppBar(title: 'Formulario'),
      body: Form(
        key: key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ingrese su nombre',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacío';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomButtonWidget(
              text: 'Enviar',
              size: MediaQuery.of(context).size,
              function: onPressed,
              currentColor: Theme.of(context).colorScheme,
            ),
          ],
        ),
      ),
    );
  }
}
