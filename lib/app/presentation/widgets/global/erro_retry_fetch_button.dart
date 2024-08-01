import 'package:autotureid/app/presentation/widgets/global/primary_elevated_button.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class ErrorRetryFetchButton extends StatelessWidget {
  const ErrorRetryFetchButton({
    super.key,
    required this.failure,
    required this.onRetry,
  });

  final String failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          failure,
          style: kSubtitle5TextStyle,
        ),
        const SizedBox(height: 8),
        PrimaryElevatedButton(
          text: 'Coba lagi',
          dense: true,
          onPressed: onRetry,
        ),
      ],
    );
  }
}
