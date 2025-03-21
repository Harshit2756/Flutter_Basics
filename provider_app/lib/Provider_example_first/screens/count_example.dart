// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/count_provider.dart';

class CountExample extends StatefulWidget {
  const CountExample({super.key});

  @override
  CountExampleState createState() => CountExampleState();
}

class CountExampleState extends State<CountExample> {
  @override
  void initState() {
    super.initState();
    print("initState");
    // . listen is set to false to avoid the widget tree from rebuilding
    final countProvider = Provider.of<CountProvider>(context, listen: false);

    Timer.periodic(Duration(seconds: 1), (timer) {
      countProvider.setCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    // . listen is set to false to avoid the widget tree from rebuilding when the count changes only the widget wrapped in the Consumer will rebuild
    final countProvider = Provider.of<CountProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Count Example"),
      ),
      body: Center(
        // . only this widget will rebuild when the count changes because it is wrapped in the Consumer and the count provider above is set to listen to false
        child: Consumer<CountProvider>(
          builder: (context, countProvider, child) {
            print("Consumer");
            return Text(
              countProvider.count.toString(),
              style: TextStyle(fontSize: 30),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countProvider.setCount();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
