part of 'counter_bloc.dart';

class CounterDecremented extends CounterEvent {}

sealed class CounterEvent {}

class CounterIncremented extends CounterEvent {}
