import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// This file is used to define the business logic of the application.
/// It is responsible for handling the events and updating the state of the application.
/// The Bloc class is a simple implementation of the BLoC pattern.
/// here we have a Bloc that takes AuthEvent and returns AuthState
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  //. onChange is called whenever the state of the Bloc changes. , it only gives the current and next state
  // @override
  // void onChange(Change<AuthState> change) {
  //   super.onChange(change);
  //   print('AuthBloc - Change - $change');
  // }

  //. onTransition is called whenever a new transition occurs in the Bloc, it gives the current state, the event(due to which the state change occur), the next state.
  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
  //   super.onTransition(transition);
  //   print('AuthBloc - Transition - $transition');
  // }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.password;
      // Email validation using Regex

      if (password.length < 6) {
        return emit(
          AuthFailure('Password cannot be less than 6 characters!'),
        );
      }

      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthSuccess(uid: '$email-$password'));
      });
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
