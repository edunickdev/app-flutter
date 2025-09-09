import 'package:flutter/material.dart';

List<Color> colors = [
  Color(0xFF02062A),
  Colors.blueAccent,
  Colors.greenAccent,
  Colors.orangeAccent,
  Colors.purpleAccent,
  Colors.redAccent,
  Colors.yellowAccent,
  Colors.tealAccent,
  Colors.cyanAccent,
  Colors.indigoAccent,
  Colors.limeAccent,
  Colors.amberAccent,
];

class AppTheme {
  int currentColor;
  bool currentMode;

  AppTheme({this.currentColor = 1, this.currentMode = false})
    : assert(currentColor >= 0 && currentColor < colors.length);

  ThemeData getTheme() {
    final brightness = currentMode ? Brightness.dark : Brightness.light;

    final colorScheme = brightness == Brightness.dark
        ? ColorScheme.dark(primary: colors[currentColor])
        : ColorScheme.light(primary: colors[currentColor]);

    return ThemeData(colorScheme: colorScheme);
  }
}
