part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class CounterIcreased extends CounterEvent {
  final int value;
  const CounterIcreased(this.value);
}

class CounterReset extends CounterEvent {
  // const CounterReset();
}
