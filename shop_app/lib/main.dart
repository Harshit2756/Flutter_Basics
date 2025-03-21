import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // * Provider
    // . Provider is a widget that provides a value to all of its children and grandchildren.
    // + lazy-loading: The value is created only when it is needed.

    // / Types of Provider:
    // . Provider
    // + Provides any type of value to the widget tree.
    // + The create parameter of Provider is a factory method that returns the value that will be provided to the widget tree.
    // + It is a read-only provider.
    // . ChangeNotifierProvider:
    // + Provides a value of type change notifier to the widget tree and rebuilds the widget tree when the value changes.
    // + A ChangeNotifier is class and notifies the listeners when the value changes.
    // + To notify the listeners, call the notifyListeners() method
    // + to access the value of ChangeNotifierProvider, use

    // - context.watch<ChangeNotifier>() [Provider.of<ChangeNotifier>(context]
    // > will listen i.e rebuild the complete widget tree when the value changes.
    // > It is used inside a build method.
    // ! It build the complete widget tree when the value changes.
    
    //- context.read<ChangeNotifier>() [Provider.of<ChangeNotifier>(context, listen: false)]
    // > will not listen i.e will not rebuild the complete widget tree when the value changes.
    // > It is used outside a build method.

    // - Consumer:
    // > Provides a value to the widget tree and rebuilds the widget on which it is used when the value changes.
    // > It is used inside a build method.
    // > It is used when we want to rebuild only a part of the widget tree when the value changes.
    // > Syntax: Consumer<ChangeNotifier>(builder: (context, value, child) {return Widget();},)

    // . StreamProvider:
    // + Provides a value to the widget tree and rebuilds the widget tree when the value changes. The value must be a Stream.
    //  + To access the value of StreamProvider, use context.watch<Stream>() or Provider.of<Stream>(context).
    // + It takes a initialData parameter that is used to provide a value to the widget tree until the first value is received from the stream.
    // + Syntax: StreamProvider(create: (context) => Stream(), initialData: [], child: Widget(),)
    // . FutureProvider:
    // + Provides a value to the widget tree and rebuilds the widget tree when the value changes. The value must be a Future.
    // + rest is same as StreamProvider.

    // . MultiProvider:
    // + Provides multiple values to the widget tree.
    // + It takes a list of providers as a parameter.
    // + It is used when we want to provide multiple values to the widget tree.
    // + Syntax: MultiProvider(providers: [Provider1, Provider2, Provider3], child: Widget(),)

    // . ProxyProvider:
    // + Provides a value to the widget tree based on the value of another provider.
    // + It takes a list of providers as a parameter.
    // + Syntax: ProxyProvider<Provider1, Provider2>(create: (context) => Provider2(), update: (context, value1, value2) => value2, child: Widget(),)

    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Shopping app',
        theme: ThemeData(
          fontFamily: 'Lato',
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
            elevation: 0,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(254, 206, 1, 1),
            primary: const Color.fromRGBO(254, 206, 1, 1),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
