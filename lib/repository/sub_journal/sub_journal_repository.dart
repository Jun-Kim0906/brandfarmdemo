
import 'package:BrandFarm/models/journal/journal_model.dart';
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubJournalRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadIssue({
    SubJournalIssue subJournalIssue,
  }) async {
    DocumentReference reference =
    _firestore.collection('Issue').doc(subJournalIssue.issid);
    await reference.set(subJournalIssue.toMap());
  }

  Future<void> updateIssue({
    SubJournalIssue subJournalIssue,
  }) async {
    DocumentReference reference =
    _firestore.collection('Issue').doc(subJournalIssue.issid);
    await reference.update(subJournalIssue.toMap());
  }

  Future<void> updateIssueComment({
    String issid, int cmts
  }) async {
    DocumentReference reference =
    _firestore.collection('Issue').doc(issid);
    await reference.update({"comments":cmts});
  }

  Future<void> uploadJournal({
    Journal journal,
  }) async {
    DocumentReference reference =
    _firestore.collection('Journal').doc(journal.jid);
    await reference.set(journal.toMap());
  }

  Future<void> updateJournal({
    Journal journal,
  }) async {
    DocumentReference reference =
    _firestore.collection('Journal').doc(journal.jid);
    await reference.update(journal.toMap());
  }
}