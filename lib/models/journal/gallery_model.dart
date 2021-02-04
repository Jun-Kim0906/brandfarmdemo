import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class GalleryModel {
  final String path;
  final String date;
  final String fid;
  final String jid;

  GalleryModel(
      {@required this.path,
      @required this.date,
      @required this.fid,
      @required this.jid});

  factory GalleryModel.fromDs(DocumentSnapshot ds) {
    return GalleryModel(
        path: ds['path'],
        date: ds['date'],
        fid: ds['fid'],
        jid: ds['jid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'path': this.path,
      'date': this.date,
      'fid': this.fid,
      'jid': this.jid,
    };
  }
}
