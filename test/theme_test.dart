import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doublevpartnersapp/config/theme.dart';

void main() {
  test('getTheme uses provided color and mode', () {
    final theme = AppTheme(currentColor: 0, currentMode: true).getTheme();
    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.primary, colors[0]);
  });

  test('AppTheme asserts when color index is out of range', () {
    expect(() => AppTheme(currentColor: colors.length), throwsAssertionError);
  });
}
