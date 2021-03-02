import 'package:flutter/foundation.dart';
import 'package:BrandFarm/utils/todays_date.dart';

class FMJournalState {
  bool isLoading;
  int navTo;

  FMJournalState({
    @required this.isLoading,
    @required this.navTo,
  });

  factory FMJournalState.empty() {
    return FMJournalState(
      isLoading: false,
      navTo: 1,
    );
  }

  FMJournalState copyWith({
    bool isLoading,
    int navTo,
  }) {
    return FMJournalState(
      isLoading: isLoading ?? this.isLoading,
      navTo: navTo ?? this.navTo,
    );
  }

  FMJournalState update({
    bool isLoading,
    int navTo,
  }) {
    return copyWith(
      isLoading: isLoading,
      navTo: navTo,
    );
  }

  @override
  String toString() {
    return '''FMIssueState{
    isLoading: $isLoading,
    navTo: $navTo,
    }
    ''';
  }
}
