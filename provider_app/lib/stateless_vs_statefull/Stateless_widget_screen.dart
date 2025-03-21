// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';

// Stateless Widget: It is a widget that does not have any state.
//. It is immutable and cannot be changed once it is built.
//. It is useful when the part of the user interface you are describing does not depend on anything other than the configuration information in the object itself and the BuildContext in which the widget is inflated.

// . means the vairiables can't be changed once it is built.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //- this vairiable gives error if final is not added and the constructor is const
  final int x = 10;
  @override
  Widget build(BuildContext context) {
    print("Build is called once.");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Provider Demo')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              x.toString(),
              style: const TextStyle(fontSize: 50),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "On pressing the button x++ is done but not reflected on the screen as the widget is build once. \nTo update the value of x we need to use Stateful Widget.",
              style: TextStyle(fontSize: 32),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Floating Action Button");
          // x++;
          print(x.toString());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
