import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/auth_provider.dart';

class CallbackScreen extends ConsumerWidget {
  const CallbackScreen({super.key});

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(authProvider.notifier).getUser();
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      }
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            // Text(
            //   'Obteniendo sesión del usuario...',
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            // ),
          ],
        ),
      ),
    );
  }
}
