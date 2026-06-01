import 'package:flutter/material.dart';

import '../../helpers/validators.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.label,
    this.email = false,
    this.required = true,
    super.key,
  });

  final TextEditingController controller;
  final String label;

  final bool email;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      decoration: InputDecoration(
        label: Text(label),
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
      textInputAction: TextInputAction.done,
      textCapitalization: .none,
      autocorrect: false,
      validator: (String? value) {
        if (required) {
          if (value == null || value.isEmpty) {
            return 'L\'email est obligatoire';
          }
        }

        if (email) {
          String? emailError = isEmail(value);

          if (emailError == null) {
            return null;
          }

          return emailError;
        }

        return null;
      },
      controller: controller,
    );
  }
}
