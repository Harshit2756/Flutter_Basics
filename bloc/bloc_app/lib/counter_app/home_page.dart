import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_bloc.dart';
import 'inc_dec_page.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // The state of the CounterCubit is accessed using the state property. It is onetime access like it will not update the UI when the state changes.
    // final counter = counterCubit.state;

    // The BlocBuilder widget is used to rebuild the UI when the state of the CounterCubit changes.

    //. final counterCubit = BlocProvider.of<CounterCubit>(context);
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, int>(
                //. bloc: counterCubit,
                bloc: counterBloc,
                builder: (context, state) {
                  return Text(
                    '$state',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const IncDecPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
