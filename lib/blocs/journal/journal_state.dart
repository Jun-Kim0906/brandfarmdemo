
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JournalState {
  bool isLoading;
  List currentList;
  List previousList;
  List items;
  List<GlobalKey> globalKey;

  String year;
  String month;

  JournalState({
    @required this.isLoading,
    @required this.currentList,
    @required this.previousList,
    @required this.items,
    @required this.globalKey,
    @required this.year,
    @required this.month,
  });

  factory JournalState.empty() {
    return JournalState(
      isLoading: false,
      currentList: [],
      previousList: [],
      items: [],
      globalKey: [],
      year: '',
      month: '',
    );
  }

  JournalState copyWith({
    bool isLoading,
    List currentList,
    List previousList,
    List items,
    List<GlobalKey> globalKey,
    String year,
    String month,
  }) {
    return JournalState(
      isLoading: isLoading ?? this.isLoading,
      currentList: currentList ?? this.currentList,
      previousList: previousList ?? this.previousList,
      items: items ?? this.items,
      globalKey: globalKey ?? this.globalKey,
      year: year ?? this.year,
      month: month ?? this.month,
    );
  }

  JournalState update({
    bool isLoading,
    List currentList,
    List previousList,
    List items,
    List<GlobalKey> globalKey,
    String year,
    String month,
  }) {
    return copyWith(
      isLoading: isLoading,
      currentList: currentList,
      previousList: previousList,
      items: items,
      globalKey: globalKey,
      year: year,
      month: month,
    );
  }

  @override
  String toString() {
    return '''JournalState{
    isLoading: $isLoading,
    currentList: ${currentList.length},
    previousList: ${previousList.length},
    items: ${items.length},
    globalKey: ${globalKey.length},
    year: ${year},
    month: ${month},
    }
    ''';
  }
}
