
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JournalState {
  bool isLoading;
  bool isLoadingToGetMore;

  List orderByOldest;
  List orderByRecent;
  List listBySelection;

  List issueList;
  List issueListByCategorySelection;
  List reverseIssueList;
  List issueImageList;

  JournalState({
    @required this.isLoading,
    @required this.isLoadingToGetMore,
    @required this.orderByOldest,
    @required this.orderByRecent,
    @required this.listBySelection,
    @required this.issueList,
    @required this.issueListByCategorySelection,
    @required this.reverseIssueList,
    @required this.issueImageList,
  });

  factory JournalState.empty() {
    return JournalState(
      isLoading: false,
      isLoadingToGetMore: false,
      orderByOldest: [],
      orderByRecent: [],
      listBySelection: [],
      issueList: [],
      issueListByCategorySelection: [],
      reverseIssueList: [],
      issueImageList: [],
    );
  }

  JournalState copyWith({
    bool isLoading,
    bool isLoadingToGetMore,
    List orderByOldest,
    List orderByRecent,
    List listBySelection,
    List issueList,
    List issueListByCategorySelection,
    List reverseIssueList,
    List issueImageList,
  }) {
    return JournalState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingToGetMore: isLoadingToGetMore ?? this.isLoadingToGetMore,
      orderByOldest: orderByOldest ?? this.orderByOldest,
      orderByRecent: orderByRecent ?? this.orderByRecent,
      listBySelection: listBySelection ?? this.listBySelection,
      issueList: issueList ?? this.issueList,
      issueListByCategorySelection: issueListByCategorySelection ?? this.issueListByCategorySelection,
      reverseIssueList: reverseIssueList ?? this.reverseIssueList,
      issueImageList: issueImageList ?? this.issueImageList,
    );
  }

  JournalState update({
    bool isLoading,
    bool isLoadingToGetMore,
    List orderByOldest,
    List orderByRecent,
    List listBySelection,
    List issueList,
    List issueListByCategorySelection,
    List reverseIssueList,
    List issueImageList,
  }) {
    return copyWith(
      isLoading: isLoading,
      isLoadingToGetMore: isLoadingToGetMore,
      orderByOldest: orderByOldest,
      orderByRecent: orderByRecent,
      listBySelection: listBySelection,
      issueList: issueList,
      issueListByCategorySelection: issueListByCategorySelection,
      reverseIssueList: reverseIssueList,
      issueImageList: issueImageList,
    );
  }

  @override
  String toString() {
    return '''JournalState{
    isLoading: $isLoading,
    isLoadingToGetMore: $isLoadingToGetMore,
    orderByOldest: ${orderByOldest.length},
    orderByRecent: ${orderByRecent.length},
    listBySelection: ${listBySelection.length},
    issueList: ${issueList.length},
    issueListByCategorySelection: ${issueListByCategorySelection.length},
    reverseIssueList: ${reverseIssueList.length},
    issueImageList: ${issueImageList.length},
    }
    ''';
  }
}
