import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/home_screen.dart';
import 'package:riverpod_app/user.dart';
import 'package:http/http.dart' as http;

// * Providers
// . Provide :
// +  it is an object that provides data to Widgets or other providers
// + it is a read-only widget and cannot update the value inside of it
// + it can be used to provide primitive non-primitive data types and even instances of classes.
// . StateProvider :
// + It is a provider that can be used to provide a state to the widget tree.
// + It is used to update the value of the provider from anywhere in the widget tree.
// . StateNotifierProvider & ChangeNotifierProvider :
// . Future Provider
// + It is a provider that can be used to provide a future to the widget tree. i.e. it is used to provide the data that is fetched from the network.
// + It is a replacement for the FutureBuilder widget (because it is gies the access to the asynv value in the widget tree).
// ~ AsyncValue vs asynsnapshot
// + a snapshot is a class that contains the data that is fetched from the network.
// + Asyncsnapshot is a class that contains the data that is fetched from the network and the state of the data i.e. whether the data is loading or not.
// + AsyncValue is a class that contains the data that is fetched from the network and the state of the data i.e. whether the data is loading or not and the error if any.
// + But the difference between Asyncsnapshot and AsyncValue is that AsyncValue is immutable and it gives the access to the data error and the loading state by using the when method. 
// . Stream Provider

// - here ref is a provider reference that is used to communicate from a provider to another provider
// final userProvider = StateNotifierProvider<UserNotifier, User>(
//   (ref) => UserNotifier(const User(name: '', age: 0)),
// );
// final userChangeNotifierProvider = ChangeNotifierProvider(
//   (ref) => UserNotifierChange(),
// );

// - now to access the value of the provider in different file we have the reading property of the provider
// - there are two ways to read the value of the provider
// + 1. using ConsumerWidget class
// + Eg: shown in home_screen.dart
// + 2. using the consumer

final fetchUserProvider = FutureProvider<User>((ref) {
  const url = 'https://jsonplaceholder.typicode.com/users/1';
  return http.get(Uri.parse(url)).then((value) => User.fromJson(value.body));
});

void main() {
  runApp(
    // * ProviderScope
    //. ProviderScope is a widget that allows you to use providers within your application.
    //. It is the equivalent of MultiProvider in provider.
    // . It is safe to declare provider globally as they are immutable except for the state provider.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
