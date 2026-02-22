import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _indexNavigationBar = 0;

  int get getIndexNavigationBar => _indexNavigationBar;

  void setIndexNavigationBar(int value) {
    _indexNavigationBar = value;
    notifyListeners();
  }
}
