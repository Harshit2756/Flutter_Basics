// ignore_for_file: avoid_unnecessary_containers,  avoid_print

import 'dart:async';

import 'package:flutter/material.dart';

class WhyProvider extends StatefulWidget {
  const WhyProvider({super.key});

  @override
  WhyProviderState createState() => WhyProviderState();
}

class WhyProviderState extends State<WhyProvider> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    print("Init state is called ");
    Timer.periodic(const Duration(seconds: 1), (timer) {
      count++;
      print(count);
      // . This will rebuild the widget with the new value of count after every second.
      // . the complete widget tree will be rebuilt which is very costly in terms of performance.
      /// . This is where the provider package comes into the picture.
      setState(() {});
    });
  }

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
        ],
      ),
    );
  }
}
