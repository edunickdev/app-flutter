import 'package:doublevpartnersapp/presentation/components/custom_appbar_widget.dart';
import 'package:doublevpartnersapp/presentation/components/custom_button_widget.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombres',
                  hintText: 'Ingrese sus nombres',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo no puede estar vacío';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.02),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Apellidos',
                  hintText: 'Ingrese sus apellidos',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo no puede estar vacío';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.02),
              
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
      ),
    );
  }
}
