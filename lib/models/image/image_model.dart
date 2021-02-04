

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Image {
  String fid;
  String jid;
  String pid;
  String url;
  Timestamp dttm;


  Image({@required this.fid,@required this.jid,@required this.pid,@required this.url,@required this.dttm});

  factory Image.fromSnapshot(DocumentSnapshot snapshot) {
    return Image(
      fid: snapshot['fid'],
      jid: snapshot['jid'],
      pid: snapshot['pid'],
      url: snapshot['url'],
      dttm: snapshot['dttm'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fid': fid,
      'jid': jid,
      'pid': pid,
      'url': url,
      'dttm': dttm,
    };
  }
}