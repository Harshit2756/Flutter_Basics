import 'package:flutter/material.dart';
//  Relative import
// ~ here we are importing the CurrencyConverterMaterialPage widget from the currency_converter_material_page.dart file.
import './currency_converter_material_page.dart';

import 'package:flutter/cupertino.dart';
import './currency_converter_cupertino_page.dart';

void main() {
  //~ runApp is a method which takes a widget and makes it the root of the widget tree.
  // ~ here we use const keyword to make the widget immutable(we can't change the widget i.e is we don't have to rebuilt the widget.).
  runApp(const MyCupertinoApp());
}

// . Types of widgets
// 1. Stateless widget(immutable : data can't change the widget)
// 2. Stateful widget(mutable : data can change the widget)
// State:it is a information that can be read synchronously when the widget is built and might change during the lifetime of the widget.

// . Types of Design System
// 1. Material Design by Google for Android
// 2. Cupertino Design by Apple for iOS
// 3. Flat Design by Microsoft for Windows 8

class MyApp extends StatelessWidget {
  //~ here below we are using key to uniquely identify the widget in the widget tree.
  // ~ here the constructor of the MyApp widget is const i.e we don't have to rebuild the widget as it will not change(Immutable) with time which will increase the performance of the app.
  const MyApp({super.key});

  //~ we have to override the build method of the stateless widget.
  @override
  Widget build(BuildContext context) {
    //~ MaterialApp is a widget which provides a number of features like title,theme,home,etc.
    // ~ material app is used to add navigation,theme,localization,etc to the app.
    return const MaterialApp(
      // ~ home is a property of MaterialApp widget which is used to set the home screen of the app.
      home: CurrencyConverterMaterialPage(),
    );
  }
}

class MyCupertinoApp extends StatelessWidget {
  const MyCupertinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CurrencyConverterCupertinoPage(),
    );
  }
}