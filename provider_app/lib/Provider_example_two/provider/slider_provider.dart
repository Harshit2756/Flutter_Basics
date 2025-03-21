import 'package:flutter/material.dart';

class SiderProvider with ChangeNotifier {
  double _opacity = 1.0;

  double get opacity => _opacity;

  void setOpacity(double opacity) {
    _opacity = opacity;
    notifyListeners();
  }
}
