// ignore_for_file: no_logic_in_create_state, unused_field

import 'package:flutter/material.dart';

// Stateful Widget: It is a widget that has mutable state.
//.It is useful when part of the user interface depends on some data that may change during the lifetime of the widget.
// . It is created by extending StatefulWidget class and overriding createState() method.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key) {
    debugPrint('From Constructor');
  }

  //. createState(): It is a method that creates an instance of State class that manages the state of the widget.
  @override
  State<MyStatefulWidget> createState() {
    debugPrint('From createState()');
    return _MyStatefulWidgetState();
  }
}

// State: It is a class that contains the configuration information for a StatefulWidget.

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // . We can access the state of the widget using different methods

  // . 1. initState(): It is a method that is called only once when the stateful widget is inserted into the widget tree.
  // . It is used to initialize the data , subscribe to streams or connect to  sockets.
  late int _counter;
  @override
  void initState() {
    super.initState();
    _counter = 0;
    debugPrint('From initState()');
  }

  // . 2. didChangeDependencies(): It is a method that is called immediately after initState() method.
  // . It is used to subscribe to streams or any other object that depends on the BuildContext.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('From didChangeDependencies()');
  }

  // . 3. didUpdateWidget(): It is a method that is called when the parent widget changes and the framework is required to update the widget.
  // . It is used to compare the old widget with the new widget and update the state accordingly.
  @override
  void didUpdateWidget(covariant MyStatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('From didUpdateWidget()');
  }

  // . 4. setState(): It is a method that is called when the state of the widget is changed.
  // . It is used to update the state of the widget.
  // . It is called when the user interacts with the widget.
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  // . 5. dispose(): It is a method that is called when the widget is removed from the widget tree permanently.
  // . It is used to unsubscribe from streams or any other object that depends on the BuildContext.
  @override
  void dispose() {
    super.dispose();
    debugPrint('From dispose()');
  }

  // . 6. build(): It is a method that is called when the widget is inserted into the widget tree.
  // . It is used to describe the part of the user interface represented by the widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Center(
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.music_note),
                          title: const Text('Music'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.videocam),
                          title: const Text('Video'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera),
                          title: const Text('Camera'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            child: const Text('Click Me'),
          ),
        );
      }),
    );
  }
}
