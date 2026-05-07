import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final bool isLoading;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: Wrap(
        spacing: 16,
        crossAxisAlignment: .center,
        children: [
          if (isLoading)
            const SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          Text(isLoading ? 'Loading...' : label),
        ],
      ),
    );
  }
}
