import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumericFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final num? initialValue;
  final bool allowDecimal;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomNumericFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.initialValue,
    this.allowDecimal = false,
    this.onChanged,
    this.validator,
  });

  @override
  State<CustomNumericFormField> createState() => _CustomNumericFormFieldState();
}

class _CustomNumericFormFieldState extends State<CustomNumericFormField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    // Inicializa el valor (si viene nulo, usa "0")
    _controller = TextEditingController(
      text: (widget.initialValue ?? 0).toString(),
    );

    // Escucha los cambios y evita valor vacío
    _controller.addListener(() {
      final text = _controller.text.trim();
      if (text.isEmpty) {
        // Si lo borran todo, reponemos con 0
        _controller.text = '0';
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
      widget.onChanged?.call(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    const borderRadius = Radius.circular(15);

    final inputFormatters = <TextInputFormatter>[
      FilteringTextInputFormatter.allow(
        RegExp(widget.allowDecimal ? r'^\d*\.?\d*$' : r'^\d*$'),
      ),
    ];

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
        controller: _controller,
        validator: widget.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'El campo no puede estar vacío';
              }
              return null;
            },
        keyboardType: widget.allowDecimal
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.number,
        inputFormatters: inputFormatters,
        style: const TextStyle(fontSize: 20, color: Colors.black54),
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
          isDense: true,
          label: widget.label != null ? Text(widget.label!) : null,
          hintText: widget.hint,
          errorText: widget.errorMessage,
          focusColor: colors.primary,
        ),
      ),
    );
  }
}
