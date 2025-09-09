import 'package:doublevpartnersapp/presentation/components/custom_appbar_widget.dart';
import 'package:doublevpartnersapp/presentation/components/user_card_widget.dart';
import 'package:doublevpartnersapp/presentation/context/context.dart';
import 'package:doublevpartnersapp/repository/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({super.key});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(usersProvider.notifier).loadUsers());
  }

  void _showUserDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('${user.names} ${user.lastnames}'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: user.addresses.length,
            itemBuilder: (_, index) {
              final a = user.addresses[index];
              return ListTile(
                title: Text(
                  '${a.country} • ${a.department} • ${a.municipality}',
                ),
                subtitle: Text(a.address),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar usuario'),
        content: const Text('¿Desea eliminar este usuario?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirm ?? false) {
      await ref.read(usersProvider.notifier).deleteUser(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(usersProvider);

    return Scaffold(
      appBar: HomeAppBar(title: 'Detalles'),
      body: usersState.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text('Sin usuarios registrados'));
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, index) {
              final user = users[index];
              return UserCardWidget(
                user: user,
                onTap: () => _showUserDialog(user),
                onDelete: () => _confirmDelete(user.id),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Error al cargar usuarios')),
      ),
    );
  }
}
