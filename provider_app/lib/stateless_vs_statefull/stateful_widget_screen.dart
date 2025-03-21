// ignore_for_file: avoid_unnecessary_containers,  avoid_print

import 'package:flutter/material.dart';

class StateFulWidetState extends StatefulWidget {
  const StateFulWidetState({super.key});

  @override
  StateFulWidetStateState createState() => StateFulWidetStateState();
}

class StateFulWidetStateState extends State<StateFulWidetState> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    print("Build is called ");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Provider Demo')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Text(
                count.toString(),
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Text(
          //     "On pressing the button x++ is done but not reflected on the screen as the widget is build once. \nTo update the value of x we need to use Stateful Widget.",
          //     style: TextStyle(fontSize: 32),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Floating Action Button");
          count++;
          print(count.toString());

          // . setState(): It is a method that is called when the state of the widget is changed.
          // . It rebuilds the complete widget tree with the update val stored in the vairiable count.
          // ~ The problem with this is that  the whole widget tree is rebuild, where as which just wanted to update the text widget.
          /// solution to this is to use Sate management techniques like Provider, Riverpod, etc.
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
