part of 'auth_bloc.dart';

/// this file is used to define the states that the bloc can be in
/// like loading, success, failure, etc.
/// not like a button click, a text change, etc. which are events
@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  final String uid; // This could be a UserModel

  AuthSuccess({required this.uid});
}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

final class AuthLoading extends AuthState {}
