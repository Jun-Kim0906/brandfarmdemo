import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class JournalIssueCreateState {
  final String title;
  final List<File> imageList;
  final List<Asset> assetList;
  final bool isComplete;
  final bool isUploaded;

  JournalIssueCreateState({
    @required this.title,
    @required this.imageList,
    @required this.assetList,
    @required this.isComplete,
    @required this.isUploaded,
  });

  factory JournalIssueCreateState.empty() {
    return JournalIssueCreateState(
      title: '',
      imageList: [],
      assetList: [],
      isComplete: false,
      isUploaded: false,
    );
  }

  JournalIssueCreateState copyWith({
    String title,
    List<File> imageList,
    List<Asset> assetList,
    bool isComplete,
    bool isUploaded,
  }) {
    return JournalIssueCreateState(
        title: title ?? this.title,
      imageList: imageList ?? this.imageList,
      assetList: assetList ?? this.assetList,
      isComplete: isComplete ?? this.isComplete,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }

  JournalIssueCreateState update({
    String title,
    List<File> imageList,
    List<Asset> assetList,
    bool isComplete,
    bool isUploaded,
  }) {
    return JournalIssueCreateState(
        title: title,
      imageList: imageList,
      assetList: assetList,
      isComplete: isComplete,
      isUploaded: isUploaded,
    );
  }

  @override
  String toString() {
    return '''JournalIssueCreateState{
    title: $title,
    imageList: ${imageList?.length ?? 0},
    assetList: ${assetList?.length ?? 0},
    isComplete: ${isComplete},
    isUploaded: ${isUploaded},
   }''';
  }
}
