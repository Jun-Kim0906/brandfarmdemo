import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Farm {
  final String farmID;
  final String fieldCategory;
  final String managerID;

  Farm({
    @required this.farmID,
    @required this.fieldCategory,
    @required this.managerID,
  });

  factory Farm.fromSnapshot(DocumentSnapshot ds) {
    return Farm(
      farmID: ds['farmID'].toString(),
      fieldCategory: ds['fieldCategory'].toString(),
      managerID: ds['managerID'].toString(),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'farmID': farmID,
      'fieldCategory': fieldCategory,
      'managerID': managerID,
    };
  }
}
