import 'package:doublevpartnersapp/repository/models/user_model.dart';
import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({
    super.key,
    required this.user,
    required this.onTap,
    required this.onDelete,
  });

  final UserModel user;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${user.names} ${user.lastnames}'),
        subtitle: Text(
          user.addresses.length == 1
              ? '${user.addresses.length} dirección'
              : '${user.addresses.length} direcciones',
        ),
        onTap: onTap,
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
