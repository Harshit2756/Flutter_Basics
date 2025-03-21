import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';

// here the initial state is 0 which is set through the super(0) constructor
// In bloc the on method is used to listen to the events and update the state accordingly and emit is accessible in the on method which is used to update the state.
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncremented>(
      (event, emit) => emit(state + 1),
    );
    on<CounterDecremented>(
      (event, emit) => state == 0 ? emit(0) : emit(state - 1),
    );
  }
}
