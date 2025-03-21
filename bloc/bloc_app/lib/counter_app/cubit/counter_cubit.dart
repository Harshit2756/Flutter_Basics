import 'package:flutter_bloc/flutter_bloc.dart';

// the emit method is used to update the state of the cubit and it can be accessed in the methods of the cubit.

class CounterCubit extends Cubit<int> {
  // The initial state of the CounterCubit is 0. which is passed to the super constructor.
  CounterCubit() : super(0);

  void decrement() => state == 0 ? emit(0) : emit(state - 1);

  void increment() => emit(state + 1);
}
