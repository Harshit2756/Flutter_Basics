// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/main.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Selectors
    // . Selectors are used to select a part of the state from the provider.
    // . It is used to avoid unnecessary rebuilds of the widget tree.
    // final userSelect = ref.watch(userProvider.select((value) => value.name));

    final user = ref.watch(fetchUserProvider).when(
      data: (data) {
        return Text(data.name);
      },
      loading: () {
        return const CircularProgressIndicator();
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Riverpod'),
      ),
      body: const Column(
        children: [
          Center(
            child: Text(''),
          )
        ],
      ),
    );
  }
}
