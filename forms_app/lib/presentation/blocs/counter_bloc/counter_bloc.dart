import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(counter: 0, transactionCount: 0)) {
    on<CounterIcreased>(_onCounterIncreased);
    on<CounterReset>(_onCounterReset);
  }

  void _onCounterIncreased(CounterIcreased event, Emitter<CounterState> emit) {
    emit(
      state.copyWith(
          counter: state.counter + event.value,
          transactionCount: state.transactionCount + 1),
    );
  }

  void _onCounterReset(CounterReset event, Emitter<CounterState> emit) {
    emit(state.copyWith(counter: 0));
  }

  void increaseBy([int value = 1]) {
    add(CounterIcreased(value));
  }

  void resetCounter() {
    add(CounterReset());
  }
}
