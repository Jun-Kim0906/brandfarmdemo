import 'package:BrandFarm/models/farm/farm_model.dart';
import 'package:BrandFarm/models/field_model.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FMJournalRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Farm> getFarmInfo() async {
    Farm farm;
    await _firestore
        .collection('Farm')
        .where('managerID', isEqualTo: UserUtil.getUser().uid)
        .get()
        .then((qs) {
      qs.docs.forEach((ds) {
        farm = Farm.fromSnapshot(ds);
      });
    });
    return farm;
  }

  Future<List<Field>> getFieldList(String fieldCategory) async {
    List<Field> fieldList = [];
    QuerySnapshot _fieldList = await _firestore
        .collection('Field')
        .where('fieldCategory', isEqualTo: fieldCategory)
        .get();

    _fieldList.docs.forEach((ds) {
      fieldList.add(Field.fromSnapshot(ds));
    });

    return fieldList;
  }

  // Future<void> uploadIssue({
  //   SubJournalIssue subJournalIssue,
  // }) async {
  //   DocumentReference reference =
  //   _firestore.collection('Issue').doc(subJournalIssue.issid);
  //   await reference.set(subJournalIssue.toMap());
  // }
  //
  // Future<void> updateIssue({
  //   SubJournalIssue subJournalIssue,
  // }) async {
  //   DocumentReference reference =
  //   _firestore.collection('Issue').doc(subJournalIssue.issid);
  //   await reference.update(subJournalIssue.toMap());
  // }
  //
  // Future<void> updateIssueComment({String issid, int cmts}) async {
  //   DocumentReference reference = _firestore.collection('Issue').doc(issid);
  //   await reference.update({"comments": cmts});
  // }
}
