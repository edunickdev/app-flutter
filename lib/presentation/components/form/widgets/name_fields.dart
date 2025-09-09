import 'package:doublevpartnersapp/presentation/components/form/validators.dart';
import 'package:flutter/material.dart';

class NameFields extends StatelessWidget {
  const NameFields({
    super.key,
    required this.namesKey,
    required this.lastnamesKey,
  });

  final GlobalKey<FormFieldState> namesKey;
  final GlobalKey<FormFieldState> lastnamesKey;

  @override
  Widget build(BuildContext context) {
    final gap = MediaQuery.of(context).size.height * 0.02;

    return Column(
      children: [
        TextFormField(
          key: namesKey,
          decoration: const InputDecoration(
            labelText: 'Nombres',
            hintText: 'Ingrese sus nombres',
            border: OutlineInputBorder(),
          ),
          validator: Validators.notEmpty,
        ),
        SizedBox(height: gap),
        TextFormField(
          key: lastnamesKey,
          decoration: const InputDecoration(
            labelText: 'Apellidos',
            hintText: 'Ingrese sus apellidos',
            border: OutlineInputBorder(),
          ),
          validator: Validators.notEmpty,
        ),
      ],
    );
  }
}

class AddAddressFab extends StatelessWidget {
  const AddAddressFab({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
