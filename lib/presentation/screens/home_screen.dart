import 'package:doublevpartnersapp/presentation/components/custom_appbar_widget.dart';
import 'package:doublevpartnersapp/presentation/components/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final currentColor = Theme.of(context).colorScheme;

    void goForm() {
      context.push('/form');
    }

    void goDetails() {
      context.push('/details');
    }

    return Scaffold(
      appBar: const HomeAppBar(
        title: 'Vista Principal',
        showThemeToggle: true,
        showColorMenu: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonWidget(
              currentColor: currentColor,
              size: size,
              text: 'Agregar nueva persona',
              function: goForm,
            ),
            SizedBox(height: size.height * 0.02),
            CustomButtonWidget(
              currentColor: currentColor,
              size: size,
              text: 'Ver todas las personas',
              function: goDetails,
            ),
          ],
        ),
      ),
    );
  }
}
