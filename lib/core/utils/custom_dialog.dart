import 'package:flutter/material.dart';

class CustomDialog {
  final String data;
  const CustomDialog({required this.data});
  void validateInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(data),
        content: const Text("Please ensure all fields are filled correctly."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
