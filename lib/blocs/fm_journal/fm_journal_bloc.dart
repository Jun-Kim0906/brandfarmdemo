import 'package:BrandFarm/blocs/fm_journal/fm_journal_event.dart';
import 'package:BrandFarm/blocs/fm_journal/fm_journal_state.dart';
import 'package:BrandFarm/models/farm/farm_model.dart';
import 'package:BrandFarm/models/field_model.dart';
import 'package:BrandFarm/repository/fm_journal/fm_journal_repository.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:bloc/bloc.dart';

class FMJournalBloc extends Bloc<FMJournalEvent, FMJournalState> {
  FMJournalBloc() : super(FMJournalState.empty());

  @override
  Stream<FMJournalState> mapEventToState(FMJournalEvent event) async* {
    if (event is LoadFMJournalList) {
      yield* _mapLoadFMJournalListToState();
    } else if (event is ChangeScreen) {
      yield* _mapChangeScreenToState(event.navTo);
    } else if (event is SetField) {
      yield* _mapSetFieldToState(event.field);
    } else if (event is GetFieldList) {
      yield* _mapGetFieldListToState();
    } else if (event is SetJourYear) {
      yield* _mapSetJourYearToState(event.year);
    } else if (event is SetJourMonth) {
      yield* _mapSetJourMonthToState(event.month);
    } else if (event is ChangeSwitchState) {
      yield* _mapChangeSwitchStateToState();
    }
  }

  Stream<FMJournalState> _mapLoadFMJournalListToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<FMJournalState> _mapChangeScreenToState(int navTo) async* {
    yield state.update(isLoading: false, navTo: navTo);
  }

  Stream<FMJournalState> _mapSetFieldToState(Field field) async* {
    yield state.update(field: field);
  }

  Stream<FMJournalState> _mapGetFieldListToState() async* {
    Farm farm = await FMJournalRepository().getFarmInfo();
    List<Field> fieldList =
        await FMJournalRepository().getFieldList(farm.fieldCategory);

    yield state.update(
      farm: farm,
      fieldList: fieldList,
      field: fieldList[0],
    );
  }

  Stream<FMJournalState> _mapSetJourYearToState(String year) async* {
    // year
    yield state.update(
      year: year,
    );
  }

  Stream<FMJournalState> _mapSetJourMonthToState(String month) async* {
    // month
    yield state.update(
      month: month,
    );
  }

  Stream<FMJournalState> _mapChangeSwitchStateToState() async* {
    // switch
    yield state.update(
      isIssue: !state.isIssue,
    );
  }
}
