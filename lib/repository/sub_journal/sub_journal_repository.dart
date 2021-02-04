
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubJournalRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference reference;

  Future<void> uploadJournal({
    SubJournalIssue subJournalIssue,
  }) async {
    DocumentReference reference =
    _firestore.collection('Issue').doc(subJournalIssue.sfmid);
    await reference.set(subJournalIssue.toMap());
  }

  Future<void> updateJournal({
    SubJournalIssue subJournalIssue,
  }) async {
    DocumentReference reference =
    _firestore.collection('Issue').doc(subJournalIssue.sfmid);
    await reference.update(subJournalIssue.toMap());
  }
}