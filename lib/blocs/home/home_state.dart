import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:BrandFarm/utils/todays_date.dart';

class HomeState {
  bool isLoading;
  int monthState;
  int yearState;
  int dayState;
  int currentIndex;

  HomeState({
    @required this.isLoading,
    @required this.yearState,
    @required this.monthState,
    @required this.dayState,
    @required this.currentIndex,
  });

  factory HomeState.empty() {
    return HomeState(
      isLoading: false,
      monthState: int.parse('$month'),
      yearState: int.parse('$year'),
      dayState: int.parse('$day'),
      currentIndex: 0,
    );
  }

  HomeState copyWith({
    bool isLoading,
    int monthState,
    int yearState,
    int dayState,
    int currentIndex,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      monthState: monthState ?? this.monthState,
      yearState: yearState ?? this.yearState,
      dayState: dayState ?? this.dayState,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  HomeState update({
    bool isLoading,
    int monthState,
    int yearState,
    int dayState,
    int currentIndex,
  }) {
    return copyWith(
      isLoading: isLoading,
      monthState: monthState,
      yearState: yearState,
      dayState: dayState,
      currentIndex: currentIndex,
    );
  }

  @override
  String toString() {
    return '''HomeState{
    isLoading: $isLoading,
    monthState: $monthState,
    yearState: $yearState,
    dayState: $dayState,
    currentIndex: $currentIndex,
    }
    ''';
  }
}
