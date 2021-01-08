import 'package:flutter/foundation.dart';

class HomeState {
  bool isLoading;

  HomeState({
    @required this.isLoading,
  });

  factory HomeState.empty() {
    return HomeState(isLoading: false);
  }

  HomeState copyWith({
    bool isLoading,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  HomeState update({
    bool isLoading,
  }) {
    return copyWith(
      isLoading: isLoading,
    );
  }

  @override
  String toString() {
    return '''HomeState{
    isLoading: $isLoading,
    }
    ''';
  }
}
