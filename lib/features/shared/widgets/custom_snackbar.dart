import 'package:flutter/material.dart';

void customShowSnackBar(
  BuildContext context, {
  required String message,
  required bool res,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: res ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(res ? Icons.check : Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
