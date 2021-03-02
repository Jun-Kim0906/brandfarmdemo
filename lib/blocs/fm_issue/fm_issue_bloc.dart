

import 'package:BrandFarm/blocs/fm_issue/fm_issue_event.dart';
import 'package:BrandFarm/blocs/fm_issue/fm_issue_state.dart';
import 'package:bloc/bloc.dart';

class FMIssueBloc extends Bloc<FMIssueEvent, FMIssueState> {
  FMIssueBloc() : super(FMIssueState.empty());

  @override
  Stream<FMIssueState> mapEventToState(FMIssueEvent event) async* {
    if (event is LoadFMIssueList) {
      yield* _mapLoadFMIssueListToState();
    }
  }

  Stream<FMIssueState> _mapLoadFMIssueListToState() async* {
    yield state.update(isLoading: true);
  }
}