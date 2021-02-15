

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImagePicture {
  String fid;
  String jid;
  String uid;
  String issid;
  String pid;
  String url;
  Timestamp dttm;


  ImagePicture({
    @required this.fid,
    @required this.jid,
    @required this.uid,
    @required this.issid,
    @required this.pid,
    @required this.url,
    @required this.dttm,
  });

  factory ImagePicture.fromSnapshot(DocumentSnapshot snapshot) {
    return ImagePicture(
      fid: snapshot['fid'],
      jid: snapshot['jid'],
      uid: snapshot['uid'],
      issid: snapshot['issid'],
      pid: snapshot['pid'],
      url: snapshot['url'],
      dttm: snapshot['dttm'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fid': fid,
      'jid': jid,
      'uid': uid,
      'issid': issid,
      'pid': pid,
      'url': url,
      'dttm': dttm,
    };
  }
}