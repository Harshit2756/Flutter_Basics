part of 'auth_bloc.dart';
/// this file is used to define the events that can be used in the bloc to change the state
/// like a button click, a text change, etc.
/// not like loading, success, failure, etc. which are states
@immutable
sealed class AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({
    required this.email,
    required this.password,
  });
}

final class AuthLogoutRequested extends AuthEvent {}
