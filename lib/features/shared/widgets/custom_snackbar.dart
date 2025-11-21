import 'package:flutter/material.dart';

void customShowSnackBar(
  BuildContext context, {
  required String message,
  required bool res,
  Duration duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    behavior: SnackBarBehavior.fixed,
    backgroundColor: res ? Colors.green : Colors.red,
    elevation: 4,
    duration: duration,
    content: Row(
      children: [
        Icon(res ? Icons.check : Icons.close, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
