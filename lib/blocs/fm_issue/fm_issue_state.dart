import 'package:flutter/foundation.dart';
import 'package:BrandFarm/utils/todays_date.dart';

class FMIssueState {
  bool isLoading;

  FMIssueState({
    @required this.isLoading,
  });

  factory FMIssueState.empty() {
    return FMIssueState(
      isLoading: false,
    );
  }

  FMIssueState copyWith({
    bool isLoading,
  }) {
    return FMIssueState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  FMIssueState update({
    bool isLoading,
  }) {
    return copyWith(
      isLoading: isLoading,
    );
  }

  @override
  String toString() {
    return '''FMIssueState{
    isLoading: $isLoading,
    }
    ''';
  }
}
