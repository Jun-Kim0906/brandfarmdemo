
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';

class IssueUtil {
  static SubJournalIssue _issue;
  static void setIssue(SubJournalIssue issue) async {
    _issue = issue;
  }

  static SubJournalIssue getIssue() {
    return _issue;
  }
}
