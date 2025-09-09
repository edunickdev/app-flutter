import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doublevpartnersapp/presentation/context/context.dart';

import 'validators.dart';
import 'address_entry.dart';

class AddressDialog extends ConsumerStatefulWidget {
  const AddressDialog({super.key});

  @override
  ConsumerState<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends ConsumerState<AddressDialog> {
  final _formKey = GlobalKey<FormState>();
  final _addressCtrl = TextEditingController();

  @override
  void dispose() {
    _addressCtrl.dispose();
    super.dispose();
  }

  void _resetSelections() {
    ref.read(countrySelectedProvider.notifier).state = null;
    ref.read(departmentSelectedProvider.notifier).state = null;
    ref.read(municipalitySelectedProvider.notifier).state = null;
    ref.read(municipalitiesProvider.notifier).clearData();
  }

  @override
  Widget build(BuildContext context) {
    final countries = ref.watch(countriesProvider);
    final departments = ref.watch(departmentsProvider);
    final municipalities = ref.watch(municipalitiesProvider);

    final selectedCountry = ref.watch(countrySelectedProvider);
    final selectedDepartment = ref.watch(departmentSelectedProvider);
    final selectedMunicipality = ref.watch(municipalitySelectedProvider);

    return AlertDialog(
      title: const Text('Agregar dirección'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            countries.when(
              data: (data) => DropdownSearch<String>(
                items: (filter, _) => data.keys.toList(),
                selectedItem: selectedCountry,
                autoValidateMode: AutovalidateMode.onUnfocus,
                validator: (v) => v == null ? 'Seleccione un país' : null,
                onChanged: (value) {
                  ref.read(countrySelectedProvider.notifier).state = value;
                  if (value != null) {
                    ref.read(departmentSelectedProvider.notifier).state = null;
                    ref.read(municipalitiesProvider.notifier).clearData();
                    ref.read(municipalitySelectedProvider.notifier).state = null;
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => const Text('Error al cargar países'),
            ),
            const SizedBox(height: 16),
            departments.when(
              data: (data) => DropdownSearch<String>(
                items: (filter, _) => data,
                selectedItem: selectedDepartment,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => v == null ? 'Seleccione un departamento' : null,
                onChanged: (value) {
                  ref.read(departmentSelectedProvider.notifier).state = value;
                  if (value != null) {
                    final country = ref.read(countrySelectedProvider);
                    if (country != null) {
                      ref
                          .read(municipalitiesProvider.notifier)
                          .fetchMunicipalities(country, value);
                      ref.read(municipalitySelectedProvider.notifier).state = null;
                    }
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => const Text('Error al cargar departamentos'),
            ),
            const SizedBox(height: 16),
            municipalities.when(
              data: (data) => DropdownSearch<String>(
                items: (filter, _) => data,
                selectedItem: selectedMunicipality,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => v == null ? 'Seleccione un municipio' : null,
                onChanged: (v) => ref.read(municipalitySelectedProvider.notifier).state = v,
                popupProps: const PopupProps.menu(showSearchBox: true),
                decoratorProps: const DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: 'Municipio',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => const Text('Error al cargar municipios'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressCtrl,
              decoration: const InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder(),
              ),
              validator: Validators.notEmpty,
            ),
          ]),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _resetSelections();
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final result = AddressEntry(
                country: ref.read(countrySelectedProvider)!,
                department: ref.read(departmentSelectedProvider)!,
                municipality: ref.read(municipalitySelectedProvider)!,
                address: _addressCtrl.text,
              );
              _resetSelections();
              Navigator.of(context).pop(result);
            }
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
