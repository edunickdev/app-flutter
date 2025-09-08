import 'package:doublevpartnersapp/presentation/components/custom_appbar_widget.dart';
import 'package:doublevpartnersapp/presentation/components/custom_button_widget.dart';
import 'package:doublevpartnersapp/presentation/context/context.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormScreen extends ConsumerWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final key = GlobalKey<FormState>();

    void onPressed() {
      if (key.currentState!.validate()) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Procesando datos')));
      }
    }

    String? validateNotEmpty(String? value) {
      if (value == null || value.isEmpty) {
        return 'El campo no puede estar vacío';
      }
      return null;
    }

    final countries = ref.watch(countriesProvider);
    final departments = ref.watch(departmentsProvider);
    final municipalities = ref.watch(municipalitiesProvider);

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
                validator: (value) => validateNotEmpty(value),
              ),
              SizedBox(height: size.height * 0.02),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Apellidos',
                  hintText: 'Ingrese sus apellidos',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => validateNotEmpty(value),
              ),
              SizedBox(height: size.height * 0.02),
              DropdownSearch<String>(
                items: (filter, loadProps) => countries,
                selectedItem: ref.watch(countrySelectedProvider),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value == null ? 'Seleccione un país' : null,
                onChanged: (value) =>
                    ref.read(countrySelectedProvider.notifier).state = value,
                popupProps: const PopupProps.menu(showSearchBox: true),
                decoratorProps: DropDownDecoratorProps(
                  decoration: const InputDecoration(
                    labelText: 'País',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              DropdownSearch<String>(
                items: (filter, loadProps) => departments,
                selectedItem: ref.watch(departmentSelectedProvider),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value == null ? 'Seleccione un departamento' : null,
                onChanged: (value) =>
                    ref.read(departmentSelectedProvider.notifier).state = value,
                popupProps: const PopupProps.menu(showSearchBox: true),
                decoratorProps: DropDownDecoratorProps(
                  decoration: const InputDecoration(
                    labelText: 'Departamento',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              DropdownSearch<String>(
                items: (filter, loadProps) => municipalities,
                selectedItem: ref.watch(municipalitySelectedProvider),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value == null ? 'Seleccione un municipio' : null,
                onChanged: (value) =>
                    ref.read(municipalitySelectedProvider.notifier).state =
                        value,
                popupProps: const PopupProps.menu(showSearchBox: true),
                decoratorProps: DropDownDecoratorProps(
                  decoration: const InputDecoration(
                    labelText: 'Municipio',
                    border: OutlineInputBorder(),
                  ),
                ),
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
