import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required String error}) : _error = error;

  final String _error;

  String _getUserFriendlyMessage(String error) {
    final errorString = error.toLowerCase();

    if (errorString.contains('connection') ||
        errorString.contains('timeout') ||
        errorString.contains('socket') ||
        errorString.contains('refused')) {
      return 'Unable to connect to the server. Please check your internet connection and try again.';
    }

    if (errorString.contains('404') || errorString.contains('not found')) {
      return 'The requested data was not found. Please try again later.';
    }

    if (errorString.contains('500') ||
        errorString.contains('502') ||
        errorString.contains('503') ||
        errorString.contains('server')) {
      return 'Server is experiencing issues. Please try again in a few moments.';
    }

    if (errorString.contains('401') ||
        errorString.contains('403') ||
        errorString.contains('unauthorized')) {
      return 'You do not have permission to access this resource. Please try again.';
    }

    if (errorString.contains('format') ||
        errorString.contains('json') ||
        errorString.contains('parse')) {
      return 'The data format is invalid. Please try again later.';
    }

    return 'Something went wrong. Please check your connection and try again.';
  }

  @override
  Widget build(BuildContext context) {
    final userFriendlyMessage = _getUserFriendlyMessage(_error);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            Icon(Icons.warning, color: Colors.red, size: 24),
            Text(userFriendlyMessage),
          ],
        ),
      ),
    );
  }
}
