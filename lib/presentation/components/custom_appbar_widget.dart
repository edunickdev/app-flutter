import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doublevpartnersapp/config/theme.dart' show colors;
import 'package:doublevpartnersapp/presentation/context/context.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.title,
    this.showThemeToggle = true,
    this.showColorMenu = true,
  });

  final String title;
  final bool showThemeToggle;
  final bool showColorMenu;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(modeProvider);

    return AppBar(
      title: Text(title),
      actions: [
        if (showThemeToggle)
          IconButton(
            tooltip: isDarkMode
                ? 'Cambiar a modo claro'
                : 'Cambiar a modo oscuro',
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.sunny),
            onPressed: () {
              ref.read(modeProvider.notifier).state = !isDarkMode;
            },
          ),
        if (showColorMenu) const _ColorMenu(),
      ],
    );
  }
}

class _ColorMenu extends ConsumerWidget {
  const _ColorMenu();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<int>(
      tooltip: 'Elegir color',
      icon: const Icon(Icons.color_lens),
      onSelected: (int value) {
        ref.read(colorProvider.notifier).state = value;
      },
      itemBuilder: (BuildContext context) {
        final total = colors.length;
        return List<PopupMenuEntry<int>>.generate(
          total,
          (int index) => PopupMenuItem<int>(
            value: index,
            child: Row(
              children: [
                CircleAvatar(backgroundColor: colors[index]),
                const SizedBox(width: 10),
                Text('Color ${index + 1}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
