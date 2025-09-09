import 'package:flutter/material.dart';
import 'address_entry.dart';

class AddressList extends StatelessWidget {
  const AddressList({
    super.key,
    required this.addresses,
    required this.onDelete,
  });

  final List<AddressEntry> addresses;
  final void Function(int index) onDelete;

  @override
  Widget build(BuildContext context) {
    if (addresses.isEmpty) {
      return const Center(child: Text('Sin direcciones registradas'));
    }

    return ListView.separated(
      itemCount: addresses.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final a = addresses[index];
        return ListTile(
          title: Text('${a.country} • ${a.department} • ${a.municipality}'),
          subtitle: Text(a.address),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => onDelete(index),
          ),
        );
      },
    );
  }
}
