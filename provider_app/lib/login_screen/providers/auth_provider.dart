// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthProvider extends ChangeNotifier {
  bool _islLoading = false;
  bool _obsureText = true;

  bool get isLoading => _islLoading;
  bool get obscureText => _obsureText;

  void setLoading(bool value) {
    _islLoading = value;
    notifyListeners();
  }

  void setObscureText(bool value) {
    _obsureText = value;
    notifyListeners();
  }

  void login(String email, String password) async {
    setLoading(true);
    try {
      Response response = await post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        setLoading(false);
        print('Login Success');
      } else {
        print('Login Failed');
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }
}
