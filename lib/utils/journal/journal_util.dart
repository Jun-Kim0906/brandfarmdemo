import 'package:BrandFarm/models/journal/journal_model.dart';

class JournalUtil {
  static Journal _journal;
  static void setJournal(Journal journal) async {
    _journal = journal;
  }

  static Journal getJournal() {
    return _journal;
  }
}
