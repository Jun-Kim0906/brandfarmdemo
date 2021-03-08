
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';
import 'package:BrandFarm/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FMIssueRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> getDetailUserInfo(uid) async {
    User user;
    await _firestore
        .collection('User')
        .where('uid', isEqualTo: uid)
        .get()
        .then((qs) {
      qs.docs.forEach((ds) {
        user = User.fromSnapshot(ds);
      });
    });
    return user;
  }

  Future<List<SubJournalIssue>> getIssueList(
      String fid, Timestamp firstDayOfMonth, Timestamp lastDayOfMonth) async {
    List<SubJournalIssue> issueList = [];
    QuerySnapshot _issue = await _firestore
        .collection('Issue')
        .where('fid', isEqualTo: fid)
        .where('date', isGreaterThanOrEqualTo: firstDayOfMonth)
        .where('date', isLessThanOrEqualTo: lastDayOfMonth)
        .orderBy('date', descending: true)
        .get();

    _issue.docs.forEach((ds) {
      issueList.add(SubJournalIssue.fromSnapshot(ds));
    });

    return issueList;
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
