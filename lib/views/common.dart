import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message; // Optional message to show below the spinner

  const LoadingIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ],
      ),
    );
  }
}
