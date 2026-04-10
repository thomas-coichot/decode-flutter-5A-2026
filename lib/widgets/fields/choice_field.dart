import 'package:flutter/material.dart';

enum SizePerson {
  s,
  m,
  l,
  xl,
}

class ChoiceField<T> extends StatelessWidget {
  const ChoiceField({
    required this.selected,
    required this.items,
    required this.onSelected,
    required this.getLabel,
    required this.getValue,
    super.key,
  });

  final T? selected;
  final List<T> items;
  final void Function(bool, T) onSelected;
  final String Function(T) getLabel;
  final T? Function(T?) getValue;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      crossAxisAlignment: .center,
      children: items.map((size) {
        return ChoiceChip(
          onSelected: (v) => onSelected(v, size),
          label: Text(getLabel(size)),
          selected: getValue(size) == getValue(selected),
        );
      }).toList(),
    );
  }
}
