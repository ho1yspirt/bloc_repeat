part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterSuccess extends CounterState {
  final int counter;
  CounterSuccess({required this.counter});
}

class CounterLoading extends CounterState {}

class CounterError extends CounterState {}
