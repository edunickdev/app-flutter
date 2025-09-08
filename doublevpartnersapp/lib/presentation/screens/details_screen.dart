import 'package:doublevpartnersapp/presentation/components/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(title: 'Detalles'),
      body: const Center(child: Text('This is the details screen')),
    );
  }
}
