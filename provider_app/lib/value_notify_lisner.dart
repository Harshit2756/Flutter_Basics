// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class NotifyListenerScreen extends StatelessWidget {
  NotifyListenerScreen({super.key});

  ValueNotifier<int> counter = ValueNotifier<int>(0);
  ValueNotifier<bool> toggle = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueNotifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder<bool>(
              valueListenable: toggle,
              builder: (BuildContext context, bool value, Widget? child) {
                return TextFormField(
                  obscureText: toggle.value,
                  decoration: InputDecoration(
                    hintText: 'Value',
                    suffixIcon: InkWell(
                      child: Icon(toggle.value
                          ? Icons.remove_red_eye
                          : Icons.visibility_off),
                      onTap: () {
                        toggle.value = !toggle.value;
                      },
                    ),
                  ),
                  onChanged: (value) {
                    counter.value = int.parse(value);
                  },
                );
              },
            ),
            ValueListenableBuilder<int>(
              valueListenable: counter,
              builder: (BuildContext context, int value, Widget? child) {
                return Text('Value: $value');
              },
            ),
            ElevatedButton(
              onPressed: () {
                counter.value++;
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
