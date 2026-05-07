import 'package:flutter/material.dart';

class ValueNotifierExample extends StatefulWidget {
  const ValueNotifierExample({super.key});

  @override
  State<ValueNotifierExample> createState() => _ValueNotifierExampleState();
}

class _ValueNotifierExampleState extends State<ValueNotifierExample> {
  final ValueNotifier<int> _notifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${_notifier.value}'), // Valeur pas mise à jour
        ElevatedButton(
          onPressed: _onUpdate,
          child: const Text('Update'),
        ),

        ValueListenableBuilder(
          valueListenable: _notifier,
          builder: (context, value, _) {
            return Text('Update $value'); // Mise à jour
          },
        ),
      ],
    );
  }

  void _onUpdate() {
    _notifier.value = _notifier.value + 1;

  }
}
