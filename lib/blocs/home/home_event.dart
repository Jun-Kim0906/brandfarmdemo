import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ExampleEvent extends HomeEvent{

}

class NextMonthClicked extends HomeEvent{
  @override
  String toString() => 'NextMonthClicked';
}

class PrevMonthClicked extends HomeEvent{
  @override
  String toString() => 'PrevMonthClicked';
}