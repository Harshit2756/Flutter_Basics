import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cartList = [];

  void addToCart(Map<String, dynamic> product) {
    cartList.add(product);
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> product) {
    cartList.remove(product);
    notifyListeners();
  }
}
