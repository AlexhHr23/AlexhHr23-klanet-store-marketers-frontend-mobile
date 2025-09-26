import 'package:flutter/material.dart';

class ContainerBackground extends StatelessWidget {
  final Widget child;
  const ContainerBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.white;

    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          // Fondo negro
          Positioned.fill(child: Container(color: backgroundColor)),
          // Child widget
          Center(child: child),
        ],
      ),
    );
  }
}
