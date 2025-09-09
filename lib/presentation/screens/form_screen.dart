import 'package:doublevpartnersapp/presentation/components/custom_appbar_widget.dart';
import 'package:doublevpartnersapp/presentation/components/custom_button_widget.dart';
import 'package:doublevpartnersapp/presentation/context/context.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(countriesProvider.notifier).fetchData());
  }

  final _formKey = GlobalKey<FormState>();

  void _onPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Procesando datos')));
    }
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final countries = ref.watch(countriesProvider);
    final departments = ref.watch(departmentsProvider);
    final municipalities = ref.watch(municipalitiesProvider);

    return Scaffold(
      appBar: HomeAppBar(title: 'Formulario'),
      body: Form(
        key: _formKey,
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
                validator: _validateNotEmpty,
              ),
              SizedBox(height: size.height * 0.02),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Apellidos',
                  hintText: 'Ingrese sus apellidos',
                  border: OutlineInputBorder(),
                ),
                validator: _validateNotEmpty,
              ),
              SizedBox(height: size.height * 0.02),

              // País
              DropdownSearch<String>(
                items: (filter, loadProps) => countries.when(
                  data: (data) => data,
                  loading: () => [],
                  error: (e, st) => [],
                ),
                selectedItem: ref.watch(countrySelectedProvider.notifier).state,
                autoValidateMode: AutovalidateMode.onUnfocus,
                validator: (value) =>
                    value == null ? 'Seleccione un país' : null,
                onChanged: (value) {
                  ref.read(countrySelectedProvider.notifier).state = value;
                  if (value != null) {
                    ref
                        .read(departmentsProvider.notifier)
                        .fetchDepartments(value);
                    ref.read(departmentSelectedProvider.notifier).state = null;
                    ref.read(municipalitiesProvider.notifier).clearData();
                    ref.read(municipalitySelectedProvider.notifier).state =
                        null;
                  }
                },
                popupProps: const PopupProps.menu(showSearchBox: true),
                decoratorProps: const DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: 'País',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Departamento
              DropdownSearch<String>(
                items: (filter, loadProps) => departments.when(
                  data: (data) => data,
                  loading: () => [],
                  error: (e, st) => [],
                ),
                selectedItem: ref
                    .watch(departmentSelectedProvider.notifier)
                    .state,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value == null ? 'Seleccione un departamento' : null,
                onChanged: (value) {
                  ref.read(departmentSelectedProvider.notifier).state = value;
                  if (value != null) {
                    ref
                        .read(municipalitiesProvider.notifier)
                        .fetchMunicipalities(value);
                    ref.read(municipalitySelectedProvider.notifier).state =
                        null;
                  }
                },
                popupProps: const PopupProps.menu(showSearchBox: true),
                decoratorProps: const DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: 'Departamento',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Municipio
              DropdownSearch<String>(
                items: (filter, loadProps) => municipalities.when(
                  data: (data) => data,
                  loading: () => [],
                  error: (e, st) => [],
                ),
                selectedItem: ref
                    .watch(municipalitySelectedProvider.notifier)
                    .state,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value == null ? 'Seleccione un municipio' : null,
                onChanged: (value) {
                  ref.read(municipalitySelectedProvider.notifier).state = value;
                },
                popupProps: const PopupProps.menu(showSearchBox: true),
                decoratorProps: const DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: 'Municipio',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.02),
              const SizedBox(height: 20),

              CustomButtonWidget(
                text: 'Enviar',
                size: size,
                function: () => _onPressed(context),
                currentColor: Theme.of(context).colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
