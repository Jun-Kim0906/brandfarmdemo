
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class SubJournal {
  final String uid;
  final String fcmToken;
  final String email;
  final String name;

  SubJournal({
    @required this.email,
    @required this.fcmToken,
    @required this.name,
    @required this.uid,
  });

  factory SubJournal.fromSnapshot(DocumentSnapshot ds) {
    return SubJournal(
      email: ds['email'].toString(),
      fcmToken: ds['fcmToken'].toString(),
      name: ds['name'].toString(),
      uid: ds['uid'].toString(),
    );
  }

  Map<String, Object> toMap() {
    return {
      'email': email,
      'fcmToken': fcmToken,
      'name': name,
      'uid': uid,
    };
  }
}

// sub journal - issue information
class SubJournalIssue {
  final Timestamp date;
  final String fid;
  final String sfmid;
  final String issid;
  final String uid;
  final String title;
  final int category; // 작물 1 / 시설 2 / 기타 3
  final int issueState; // 예상 1 / 진행 2 / 완료 3
  final String contents;
  final int comments;

  SubJournalIssue({
    @required this.date,
    @required this.fid,
    @required this.sfmid,
    @required this.issid,
    @required this.uid,
    @required this.title,
    @required this.category,
    @required this.issueState,
    @required this.contents,
    @required this.comments,
  });

  factory SubJournalIssue.fromSnapshot(DocumentSnapshot ds) {
    return SubJournalIssue(
      date: ds['date'],
      fid: ds['fid'],
      sfmid: ds['sfmid'],
      issid: ds['issid'],
      uid: ds['uid'],
      title: ds['title'],
      category: ds['category'],
      issueState: ds['issueState'],
      contents: ds['contents'],
      comments: ds['comments'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'fid': fid,
      'sfmid': sfmid,
      'issid': issid,
      'uid': uid,
      'title': title,
      'category': category,
      'issueState': issueState,
      'contents': contents,
      'comments': comments,
    };
  }
}

// for testing purposes
class IssueItem {
  IssueItem({
    this.date,
    this.issueState,
  });

  DateTime date;
  int issueState;
}