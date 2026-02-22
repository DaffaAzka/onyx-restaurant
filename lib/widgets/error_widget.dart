import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required String error}) : _error = error;

  final String _error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.warning, color: Colors.red, size: 24),
            Text(_error),
          ],
        ),
      ),
    );
  }
}
