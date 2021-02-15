import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class JournalIssueModifyState {
  final String title;
  final List<File> imageList;
  final List<Asset> assetList;
  final List existingImageList;
  final List deletedFromExistingImageList;
  final bool isComplete;
  final bool isUploaded;

  JournalIssueModifyState({
    @required this.title,
    @required this.imageList,
    @required this.assetList,
    @required this.existingImageList,
    @required this.deletedFromExistingImageList,
    @required this.isComplete,
    @required this.isUploaded,
  });

  factory JournalIssueModifyState.empty() {
    return JournalIssueModifyState(
      title: '',
      imageList: [],
      assetList: [],
      existingImageList: [],
      deletedFromExistingImageList: [],
      isComplete: false,
      isUploaded: false,
    );
  }

  JournalIssueModifyState copyWith({
    String title,
    List<File> imageList,
    List<Asset> assetList,
    List existingImageList,
    List deletedFromExistingImageList,
    bool isComplete,
    bool isUploaded,
  }) {
    return JournalIssueModifyState(
      title: title ?? this.title,
      imageList: imageList ?? this.imageList,
      assetList: assetList ?? this.assetList,
      existingImageList: existingImageList ?? this.existingImageList,
      deletedFromExistingImageList: deletedFromExistingImageList ?? this.deletedFromExistingImageList,
      isComplete: isComplete ?? this.isComplete,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }

  JournalIssueModifyState update({
    String title,
    List<File> imageList,
    List<Asset> assetList,
    List existingImageList,
    List deletedFromExistingImageList,
    bool isComplete,
    bool isUploaded,
  }) {
    return copyWith(
      title: title,
      imageList: imageList,
      assetList: assetList,
      existingImageList: existingImageList,
      deletedFromExistingImageList: deletedFromExistingImageList,
      isComplete: isComplete,
      isUploaded: isUploaded,
    );
  }

  @override
  String toString() {
    return '''JournalIssueModifyState{
    title: $title,
    imageList: ${imageList?.length ?? 0},
    assetList: ${assetList?.length ?? 0},
    existingImageList: ${existingImageList?.length ?? 0},
    deletedFromExistingImageList: ${deletedFromExistingImageList?.length ?? 0},
    isComplete: ${isComplete},
    isUploaded: ${isUploaded},
   }''';
  }
}
