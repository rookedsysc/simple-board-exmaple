import 'package:flutter/material.dart';

class ErrorAlert {
  final BuildContext context;
  final dynamic err;
  ErrorAlert({required this.context, required this.err});
  void snackBar() {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
        ),
      );
    }
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(err.toString()),
      ),
    );
  }
}
