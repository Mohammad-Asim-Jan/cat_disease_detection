import 'package:flutter/material.dart';

class ShowSnackBar {
  static getSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
