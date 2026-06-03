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

class ChoicesField<T> extends StatelessWidget {
  const ChoicesField({
    required this.selected,
    required this.items,
    required this.onSelected,
    required this.getLabel,
    required this.getValue,
    this.label,
    super.key,
  });

  final String? label;
  final List<T> selected;
  final List<T> items;
  final void Function(List<T> items) onSelected;
  final String Function(T) getLabel;
  final T Function(T) getValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 4,
      children: [
        if (label != null) Text(label!),
        Wrap(
          spacing: 16,
          crossAxisAlignment: .center,
          children: items.map((it) {
            return ChoiceChip(
              onSelected: (bool val) {
                final isSelected = _isSelected(it);
                List<T> newSelected = [...selected];

                if (isSelected) {
                  newSelected.removeWhere((e) => getValue(e) == getValue(it));
                } else {
                  newSelected.add(it);
                }

                onSelected(newSelected);
              },
              label: Text(getLabel(it)),
              selected: _isSelected(it),
            );
          }).toList(),
        ),
      ],
    );
  }

  bool _isSelected(T item) {
    return selected.any((e) => getValue(item) == getValue(e));
  }
}
