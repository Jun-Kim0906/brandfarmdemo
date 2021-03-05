import 'package:BrandFarm/models/image_picture/image_picture_model.dart';
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:BrandFarm/utils/todays_date.dart';

class FMIssueState {
  bool isLoading;
  List<SubJournalIssue> issueList;
  List<SubJournalIssue> reverseList;
  List<ImagePicture> imageList;

  String year;
  String month;

  FMIssueState({
    @required this.isLoading,
    @required this.year,
    @required this.month,
    @required this.issueList,
    @required this.reverseList,
    @required this.imageList,
  });

  factory FMIssueState.empty() {
    return FMIssueState(
      isLoading: false,
      year: DateTime.now().year.toString(),
      month: DateTime.now().month.toString(),
      issueList: [],
      reverseList: [],
      imageList: [],
    );
  }

  FMIssueState copyWith({
    bool isLoading,
    String year,
    String month,
    List<SubJournalIssue> issueList,
    List<SubJournalIssue> reverseList,
    List<ImagePicture> imageList,
  }) {
    return FMIssueState(
      isLoading: isLoading ?? this.isLoading,
      year: year ?? this.year,
      month: month ?? this.month,
      issueList: issueList ?? this.issueList,
      reverseList: reverseList ?? this.reverseList,
      imageList: imageList ?? this.imageList,
    );
  }

  FMIssueState update({
    bool isLoading,
    String year,
    String month,
    List<SubJournalIssue> issueList,
    List<SubJournalIssue> reverseList,
    List<ImagePicture> imageList,
  }) {
    return copyWith(
      isLoading: isLoading,
      year: year,
      month: month,
      issueList: issueList,
      reverseList: reverseList,
      imageList: imageList,
    );
  }

  @override
  String toString() {
    return '''FMIssueState{
    isLoading: $isLoading,
    year: $year,
    month: $month,
    issueList: ${issueList.length},
    reverseList: ${reverseList.length},
    imageList: ${imageList.length},
    }
    ''';
  }
}
