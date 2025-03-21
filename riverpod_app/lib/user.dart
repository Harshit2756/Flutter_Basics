import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class User {
  final String name;
  final int age;
  const User({
    required this.name,
    required this.age,
  });

  User copyWith({
    String? name,
    int? age,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name, age: $age)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}

// - the state that is passed to the UserNotifier is the initial state of the provider its type is decided by the type of the statenotifier<>
class UserNotifier extends StateNotifier<User> {
  UserNotifier(super.state);

  void updateName(String newname) {
    // state = User(name: newname, age: state.age);
    state = state.copyWith(name: newname);
  }

  void updateAge(int newage) {
    // state = User(name: state.newname, age: age);
    state = state.copyWith(age: newage);
  }
}

class UserNotifierChange extends ChangeNotifier {
  User user = const User(name: 'name', age: 0);

  void updateName(String newname) {
    user = user.copyWith(name: newname);
    notifyListeners();
  }

  void updateAge(int newage) {
    user = user.copyWith(age: newage);
    notifyListeners();
  }
}
