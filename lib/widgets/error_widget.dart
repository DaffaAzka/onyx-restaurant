import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, required String error}) : _error = error;

  final String _error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 12,
        children: [
          Icon(Icons.warning, color: Colors.red, size: 18),
          Text(_error),
        ],
      ),
    );
  }
}
