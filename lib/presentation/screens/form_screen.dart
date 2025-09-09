import 'package:doublevpartnersapp/presentation/components/custom_appbar_widget.dart';
import 'package:doublevpartnersapp/presentation/components/custom_button_widget.dart';
import 'package:doublevpartnersapp/presentation/context/context.dart';
import 'package:doublevpartnersapp/repository/utils/fetch_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAll();
    });
  }

  Future<void> _fetchAll() async {
    if (_loading) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final countries = await getCountries();

      if (!mounted) return;

      ref.read(countriesProvider.notifier).state = countries;
    } catch (e) {
      if (!mounted) return;
      _error = 'Error cargando datos: $e';
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    }
    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Procesando datos')));
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final countries = ref.watch(countriesProvider);
    final departments = ref.watch(departmentsProvider);
    final municipalities = ref.watch(municipalitiesProvider);

    final selectedCountry = ref.watch(countrySelectedProvider);
    final selectedDept = ref.watch(departmentSelectedProvider);
    final selectedMun = ref.watch(municipalitySelectedProvider);

    return Scaffold(
      appBar: const HomeAppBar(title: 'Formulario'),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : (_error != null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _fetchAll,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              )
            : Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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

                    DropdownSearch<String>(
                      items: (filter, loadProps) => countries,
                      selectedItem: selectedCountry,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value == null ? 'Seleccione un país' : null,
                      onChanged: (value) =>
                          ref.read(countrySelectedProvider.notifier).state =
                              value,
                      popupProps: const PopupProps.menu(showSearchBox: true),
                      decoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'País',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),

                    // DropdownSearch<String>(
                    //   items: departments,
                    //   selectedItem: selectedDept,
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   validator: (value) =>
                    //       value == null ? 'Seleccione un departamento' : null,
                    //   onChanged: (value) =>
                    //       ref.read(departmentSelectedProvider.notifier).state =
                    //           value,
                    //   popupProps: const PopupProps.menu(showSearchBox: true),
                    //   decoratorProps: const DropDownDecoratorProps(
                    //     decoration: InputDecoration(
                    //       labelText: 'Departamento',
                    //       border: OutlineInputBorder(),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: size.height * 0.02),

                    // DropdownSearch<String>(
                    //   items: municipalities,
                    //   selectedItem: selectedMun,
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   validator: (value) =>
                    //       value == null ? 'Seleccione un municipio' : null,
                    //   onChanged: (value) =>
                    //       ref
                    //               .read(municipalitySelectedProvider.notifier)
                    //               .state =
                    //           value,
                    //   popupProps: const PopupProps.menu(showSearchBox: true),
                    //   decoratorProps: const DropDownDecoratorProps(
                    //     decoration: InputDecoration(
                    //       labelText: 'Municipio',
                    //       border: OutlineInputBorder(),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: size.height * 0.02),

                    const SizedBox(height: 20),
                    CustomButtonWidget(
                      text: 'Enviar',
                      size: size,
                      function: _onSubmit,
                      currentColor: Theme.of(context).colorScheme,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
