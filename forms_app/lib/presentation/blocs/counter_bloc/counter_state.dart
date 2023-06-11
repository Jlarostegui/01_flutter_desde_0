part of 'counter_bloc.dart';

class CounterState extends Equatable {
  const CounterState({required this.counter, required this.transactionCount});

  final int counter;
  final int transactionCount;

  @override
  List<Object> get props => [counter, transactionCount];

  CounterState copyWith({int? counter, int? transactionCount}) => CounterState(
      counter: counter ?? this.counter,
      transactionCount: transactionCount ?? this.transactionCount);
}
