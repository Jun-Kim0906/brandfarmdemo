import 'package:BrandFarm/blocs/fm_issue/fm_issue_event.dart';
import 'package:BrandFarm/blocs/fm_issue/fm_issue_state.dart';
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';
import 'package:BrandFarm/repository/fm_issue/fm_issue_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FMIssueBloc extends Bloc<FMIssueEvent, FMIssueState> {
  FMIssueBloc() : super(FMIssueState.empty());

  @override
  Stream<FMIssueState> mapEventToState(FMIssueEvent event) async* {
    if (event is LoadFMIssueList) {
      yield* _mapLoadFMIssueListToState();
    } else if (event is GetIssueList) {
      yield* _mapGetIssueListToState(event.fid);
    } else if (event is SetIssYear) {
      yield* _mapSetIssYearToState(event.year);
    } else if (event is SetIssMonth) {
      yield* _mapSetIssMonthToState(event.month);
    }
  }

  Stream<FMIssueState> _mapLoadFMIssueListToState() async* {
    // loading
    yield state.update(isLoading: true);
  }

  Stream<FMIssueState> _mapGetIssueListToState(String fid) async* {
    // get list
    int year = int.parse(state.year);
    int month = int.parse(state.month);
    DateTime firstDay = DateTime(year, month, 1);
    DateTime lastDay = DateTime(year, month + 1, 0);
    Timestamp fDay = Timestamp.fromDate(firstDay);
    Timestamp lDay = Timestamp.fromDate(lastDay);

    print(fDay);
    print(lDay);

    List<SubJournalIssue> issueList =
        await FMIssueRepository().getIssueList(fid, fDay, lDay);

    List<SubJournalIssue> reverseList = List.from(issueList.reversed);

    yield state.update(
      isLoading: false,
      issueList: issueList,
      reverseList: reverseList,
    );
  }

  Stream<FMIssueState> _mapSetIssYearToState(String year) async* {
    // year
    yield state.update(year: year);
  }

  Stream<FMIssueState> _mapSetIssMonthToState(String month) async* {
    // month
    yield state.update(month: month);
  }
}
