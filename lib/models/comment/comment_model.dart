import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class Comment {
  final Timestamp date;
  final String uid;
  final String name;
  final String issid;
  final String jid;
  final String cmtid;
  final String comment;
  final bool isThereSubComment;
  final bool isExpanded;

  Comment({
    @required this.date,
    @required this.name,
    @required this.uid,
    @required this.issid,
    @required this.jid,
    @required this.cmtid,
    @required this.comment,
    @required this.isThereSubComment,
    @required this.isExpanded,
  });

  factory Comment.fromSnapshot(DocumentSnapshot ds) {
    return Comment(
      date: ds['date'],
      name: ds['name'].toString(),
      uid: ds['uid'].toString(),
      issid: ds['issid'].toString(),
      jid: ds['jid'].toString(),
      cmtid: ds['cmtid'].toString(),
      comment: ds['comment'].toString(),
      isThereSubComment: ds['isThereSubComment'],
      isExpanded: ds['isExpanded'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'date': date,
      'name': name,
      'uid': uid,
      'issid': issid,
      'jid': jid,
      'cmtid': cmtid,
      'comment': comment,
      'isThereSubComment': isThereSubComment,
      'isExpanded': isExpanded,
    };
  }
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class SubComment {
  final Timestamp date;
  final String uid;
  final String name;
  final String issid;
  final String jid;
  final String scmtid;
  final String cmtid;
  final String scomment;

  SubComment({
    @required this.date,
    @required this.name,
    @required this.uid,
    @required this.issid,
    @required this.jid,
    @required this.scmtid,
    @required this.cmtid,
    @required this.scomment,
  });

  factory SubComment.fromSnapshot(DocumentSnapshot ds) {
    return SubComment(
      date: ds['date'],
      name: ds['name'].toString(),
      uid: ds['uid'].toString(),
      issid: ds['issid'].toString(),
      jid: ds['jid'].toString(),
      scmtid: ds['scmtid'].toString(),
      cmtid: ds['cmtid'].toString(),
      scomment: ds['scomment'].toString(),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'date': date,
      'name': name,
      'uid': uid,
      'issid': issid,
      'jid': jid,
      'scmtid': scmtid,
      'cmtid': cmtid,
      'scomment': scomment,
    };
  }
}

