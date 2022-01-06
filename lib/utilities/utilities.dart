import 'package:flutter/material.dart';

class Utilities {
  void showSnackBarWithAction(
    BuildContext context,
    String text,
    String actionLabel,
    VoidCallback onPressed, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 12.0,
        content: Text(
          text,
        ),
        action: SnackBarAction(
          label: actionLabel,
          textColor: Colors.green[300],
          onPressed: onPressed,
        ),
        duration: duration,
      ),
    );
  }
}
