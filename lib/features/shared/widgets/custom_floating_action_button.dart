import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.heroTag,
    required this.color,
  });

  final IconData iconData;
  final void Function()? onPressed;
  final String heroTag;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      elevation: 0,
      backgroundColor: color,
      foregroundColor: Colors.white,
      onPressed: onPressed,
      child: Icon(iconData),
    );
  }
}
