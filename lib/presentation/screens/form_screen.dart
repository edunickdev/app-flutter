import 'package:doublevpartnersapp/presentation/components/custom_appbar_widget.dart';
import 'package:doublevpartnersapp/presentation/components/custom_button_widget.dart';
import 'package:doublevpartnersapp/presentation/components/custom_snackbar.dart';
import 'package:doublevpartnersapp/presentation/components/form/address_dialog.dart';
import 'package:doublevpartnersapp/presentation/components/form/address_entry.dart';
import 'package:doublevpartnersapp/presentation/components/form/address_list.dart';
import 'package:doublevpartnersapp/presentation/components/form/widgets/name_fields.dart';
import 'package:doublevpartnersapp/presentation/context/context.dart';
import 'package:doublevpartnersapp/repository/db/user_dao.dart';
import 'package:doublevpartnersapp/repository/models/address_model.dart';
import 'package:doublevpartnersapp/repository/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namesKey = GlobalKey<FormFieldState>();
  final _lastnamesKey = GlobalKey<FormFieldState>();

  final List<AddressEntry> _addresses = [];

  @override
  void initState() {
    super.initState();
    // Carga inicial y limpieza controlada
    Future.microtask(() {
      ref.read(countriesProvider.notifier).fetchData();
      ref.read(municipalitiesProvider.notifier).clearData();
      // Opcional: limpiar selección
      ref.read(countrySelectedProvider.notifier).state = null;
      ref.read(departmentSelectedProvider.notifier).state = null;
      ref.read(municipalitySelectedProvider.notifier).state = null;
    });
  }

  Future<void> _onSubmit(BuildContext context) async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    if (_addresses.isEmpty) {
      CustomSnackBarWidget.show(
        context,
        'Agregue al menos una dirección',
        isError: true,
      );
      return;
    }

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      names: _namesKey.currentState?.value ?? '',
      lastnames: _lastnamesKey.currentState?.value ?? '',
      addresses: _addresses
          .map(
            (a) => AddressModel(
              country: a.country,
              department: a.department,
              municipality: a.municipality,
              address: a.address,
            ),
          )
          .toList(),
    );

    final dao = UserDao(ref.read(databaseProvider));
    final success = await dao.insertUser(user);

    if (!context.mounted) return;

    CustomSnackBarWidget.show(
      context,
      success
          ? 'Usuario guardado correctamente'
          : 'Error al guardar el usuario',
      isError: !success,
    );
  }

  Future<void> _addAddress(BuildContext context) async {
    final result = await showDialog<AddressEntry>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AddressDialog(),
    );

    if (result != null) {
      setState(() => _addresses.add(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
              NameFields(namesKey: _namesKey, lastnamesKey: _lastnamesKey),
              SizedBox(height: size.height * 0.02),
              const Text('Direcciones agregadas'),
              Expanded(
                child: AddressList(
                  addresses: _addresses,
                  onDelete: (index) {
                    setState(() => _addresses.removeAt(index));
                  },
                ),
              ),
              SizedBox(height: size.height * 0.02),
              CustomButtonWidget(
                text: 'Guardar usuario',
                size: size,
                function: () {
                  _onSubmit(context);
                },
                currentColor: Theme.of(context).colorScheme,
              ),
              SizedBox(height: size.height * 0.12),
            ],
          ),
        ),
      ),
      floatingActionButton: AddAddressFab(
        onPressed: () => _addAddress(context),
      ),
    );
  }
}
