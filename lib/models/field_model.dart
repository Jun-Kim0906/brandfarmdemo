import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Field {
  final String fid;
  final String sfmid;
  final String fieldCategory;
  final String lat;
  final String lng;
  final String city;
  final String province;
  final String name;

  Field({
    @required this.fid,
    @required this.sfmid,
    @required this.fieldCategory,
    @required this.lat,
    @required this.lng,
    @required this.city,
    @required this.province,
    @required this.name,
  });

  factory Field.fromSnapshot(DocumentSnapshot ds) {
    return Field(
      fid: ds['fid'],
      sfmid: ds['sfmid'],
      fieldCategory: ds['fieldCategory'],
      lat: ds['lat'],
      lng: ds['lng'],
      city: ds['city'],
      province: ds['province'],
      name: ds['name'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'fid' : fid,
      'sfmid' : sfmid,
      'fieldCategory' : fieldCategory,
      'lat' : lat,
      'lng' : lng,
      'city' : city,
      'province' : province,
      'name' : name,
    };
  }
}
