import 'package:doublevpartnersapp/config/router.dart';
import 'package:doublevpartnersapp/config/theme.dart';
import 'package:doublevpartnersapp/presentation/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentColor = ref.watch(color);
    final currentMode = ref.watch(mode);

    return MaterialApp.router(
      routerConfig: routes,
      theme: AppTheme(
        currentColor: currentColor,
        currentMode: currentMode,
      ).getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
