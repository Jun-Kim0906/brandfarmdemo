
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
  final String sfmid;
  final String uid;
  final String title;
  final int category; // 작물 1 / 시설 2 / 기타 3
  final int issueState; // 예상 1 / 진행 2 / 완료 3
  final List imgUrl;
  final String contents;

  SubJournalIssue({
    @required this.date,
    @required this.sfmid,
    @required this.uid,
    @required this.title,
    @required this.category,
    @required this.issueState,
    @required this.imgUrl,
    @required this.contents,
  });

  factory SubJournalIssue.fromSnapshot(DocumentSnapshot ds) {
    return SubJournalIssue(
      date: ds['date'],
      sfmid: ds['sfmid'],
      uid: ds['uid'],
      title: ds['title'],
      category: ds['category'],
      issueState: ds['issueState'],
      imgUrl: List.from(ds['imgUrl']),
      contents: ds['contents'],
    );
  }

  Map<String, Object> toMap() {
    return {
      'date': date,
      'sfmid': sfmid,
      'uid': uid,
      'title': title,
      'category': category,
      'issueState': issueState,
      'imgUrl': imgUrl,
      'contents': contents,
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