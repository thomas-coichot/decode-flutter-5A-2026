import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/validators.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.controller,
    required this.label,
    this.required = true,
    super.key,
  });

  final TextEditingController controller;
  final String label;

  final bool required;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      obscureText: _showPassword,
      decoration: InputDecoration(
        constraints: const BoxConstraints(),
        label: Text(widget.label),
        suffixIcon: IconButton(
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            minimumSize: WidgetStatePropertyAll(Size.zero),
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          icon: Icon(
            Icons.visibility_rounded,
            color: colorScheme.onSurface,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      validator: (String? value) {
        if (widget.required) {
          if (value == null || value.isEmpty) {
            return 'L\'email est obligatoire';
          }
        }

        return null;
      },
      controller: widget.controller,
    );
  }
}
