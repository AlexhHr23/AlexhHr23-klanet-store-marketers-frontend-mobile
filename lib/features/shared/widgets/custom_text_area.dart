import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final String? initialValue;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int minLines;
  final int maxLines;

  const CustomTextArea({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.initialValue,
    this.keyboardType = TextInputType.multiline,
    this.onChanged,
    this.validator,
    this.minLines = 4,
    this.maxLines = 8,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(20),
    );

    const borderRadius = Radius.circular(15);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: borderRadius,
          bottomLeft: borderRadius,
          bottomRight: borderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType,
        minLines: minLines,
        initialValue: initialValue,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 18, color: Colors.black54, height: 1.4),
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          alignLabelWithHint: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          errorText: errorMessage,
          focusColor: colors.primary,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
