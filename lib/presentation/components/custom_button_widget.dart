import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final ColorScheme currentColor;
  final Size size;
  final String text;
  final VoidCallback function;

  const CustomButtonWidget({
    super.key,
    required this.currentColor,
    required this.size,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: currentColor.primary),
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size.width * 0.05,
          color: currentColor.onPrimary,
        ),
      ),
    );
  }
}
