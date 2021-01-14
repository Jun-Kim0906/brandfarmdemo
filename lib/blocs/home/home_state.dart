import 'package:flutter/foundation.dart';
import 'package:BrandFarm/utils/todays_date.dart';

class HomeState {
  bool isLoading;
  int monthState;
  int yearState;
  int dayState;

  HomeState({
    @required this.isLoading,
    @required this.yearState,
    @required this.monthState,
    @required this.dayState,
  });

  factory HomeState.empty() {
    return HomeState(
      isLoading: false,
      monthState: int.parse('$month'),
      yearState: int.parse('$year'),
      dayState: int.parse('$day'),
    );
  }

  HomeState copyWith({
    bool isLoading,
    int monthState,
    int yearState,
    int dayState,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      monthState: monthState ?? this.monthState,
      yearState: yearState ?? this.yearState,
      dayState: dayState ?? this.dayState,
    );
  }

  HomeState update({
    bool isLoading,
    int monthState,
    int yearState,
    int dayState,
  }) {
    return copyWith(
      isLoading: isLoading,
      monthState: monthState,
      yearState: yearState,
      dayState: dayState,
    );
  }

  @override
  String toString() {
    return '''HomeState{
    isLoading: $isLoading,
    monthState: $monthState,
    yearState: $yearState,
    dayState: $dayState,
    }
    ''';
  }
}
