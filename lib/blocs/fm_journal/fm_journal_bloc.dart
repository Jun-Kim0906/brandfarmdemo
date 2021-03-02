

import 'package:BrandFarm/blocs/fm_journal/fm_journal_event.dart';
import 'package:BrandFarm/blocs/fm_journal/fm_journal_state.dart';
import 'package:bloc/bloc.dart';

class FMJournalBloc extends Bloc<FMJournalEvent, FMJournalState> {
  FMJournalBloc() : super(FMJournalState.empty());

  @override
  Stream<FMJournalState> mapEventToState(FMJournalEvent event) async* {
    if (event is LoadFMJournalList) {
      yield* _mapLoadFMJournalListToState();
    } else if (event is ChangeScreen) {
      yield* _mapChangeScreenToState(event.navTo);
    }
  }

  Stream<FMJournalState> _mapLoadFMJournalListToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<FMJournalState> _mapChangeScreenToState(int navTo) async* {
    yield state.update(isLoading: false, navTo: navTo);
  }
}