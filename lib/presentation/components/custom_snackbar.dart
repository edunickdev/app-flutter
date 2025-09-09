import 'package:flutter/material.dart';

class CustomSnackBarWidget extends SnackBar {
  CustomSnackBarWidget({
    super.key,
    required String message,
    bool isError = false,
  }) : super(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
        );

  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBarWidget(message: message, isError: isError),
    );
  }
}