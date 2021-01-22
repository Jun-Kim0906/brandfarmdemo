import 'package:flutter/foundation.dart';
import 'package:BrandFarm/utils/todays_date.dart';

class HomeState {
  bool isLoading;
  int selectedMonth;
  int selectedYear;
  int selectedDate;
  int currentDate;

  HomeState({
    @required this.isLoading,
    @required this.selectedYear,
    @required this.selectedMonth,
    @required this.selectedDate,
    @required this.currentDate,
  });

  factory HomeState.empty() {
    return HomeState(
      isLoading: false,
      selectedMonth: int.parse('$month'),
      selectedYear: int.parse('$year'),
      selectedDate: int.parse('$day'),
      currentDate: int.parse('$day'),
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
      selectedMonth: monthState ?? this.selectedMonth,
      selectedYear: yearState ?? this.selectedYear,
      selectedDate: dayState ?? this.selectedDate,
      currentDate: currentIndex ?? this.currentDate,
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
    monthState: $selectedMonth,
    yearState: $selectedYear,
    dayState: $selectedDate,
    currentIndex: $currentDate,
    }
    ''';
  }
}
