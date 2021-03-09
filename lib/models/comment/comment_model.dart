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
  final String fid;
  final String imgUrl;

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
    @required this.fid,
    @required this.imgUrl,
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
      fid: ds['fid'],
      imgUrl: ds['imgUrl'],
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
      'fid': fid,
      'imgUrl': imgUrl,
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
  final String imgUrl;
  final String fid;

  SubComment({
    @required this.date,
    @required this.name,
    @required this.uid,
    @required this.issid,
    @required this.jid,
    @required this.scmtid,
    @required this.cmtid,
    @required this.scomment,
    @required this.imgUrl,
    @required this.fid,
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
      imgUrl: ds['imgUrl'].toString(),
      fid: ds['fid'].toString(),
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
      'imgUrl': imgUrl,
      'fid': fid,
    };
  }
}

