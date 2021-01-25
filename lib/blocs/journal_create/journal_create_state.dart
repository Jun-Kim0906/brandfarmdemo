import 'package:flutter/material.dart';

class JournalCreateState {
  String title;

  JournalCreateState({
    @required this.title,
  });

  factory JournalCreateState.empty() {
    return JournalCreateState(
      title: '',
    );
  }

  JournalCreateState copyWith({
    String title,
  }) {
    return JournalCreateState(title: title ?? this.title);
  }

  JournalCreateState update({
    String title,
  }) {
    return JournalCreateState(title: title);
  }

  @override
  String toString() {
    return '''JournalCreateState{
    title: $title,
   }''';
  }
}
