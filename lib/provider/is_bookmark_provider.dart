import 'package:flutter/material.dart';

class IsBookmarkProvider extends ChangeNotifier {
  bool _isBookmarked = false;

  bool get isBookmarked => _isBookmarked;

  set isBookmarked(bool value) {
    _isBookmarked = value;
    notifyListeners();
  }
}
