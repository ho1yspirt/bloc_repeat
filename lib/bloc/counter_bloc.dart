// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_repeat/counter_repo.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({
    required this.repo,
  }) : super(CounterInitial()) {
    //increment
    on<IncrementCounter>(
      (event, emit) async {
        emit(
          CounterLoading(),
        );
        await Future.delayed(const Duration(milliseconds: 500));
        int result = repo.increment(counter: event.counter);
        if (result >= 10) {
          emit(
            CounterError(),
          );
        } else {
          emit(
            CounterSuccess(counter: result),
          );
        }
      },
    );

    //decrement
    on<DecrementCounter>(
      (event, emit) async {
        emit(
          CounterLoading(),
        );
        await Future.delayed(const Duration(milliseconds: 500));
        int result = repo.decrement(counter: event.counter);
        if (result == -1) {
          emit(
            CounterError(),
          );
        } else {
          emit(
            CounterSuccess(counter: result),
          );
        }
      },
    );
  }
  final CounterRepo repo;
}
