import 'package:BrandFarm/blocs/journal/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  JournalBloc() : super(JournalState.empty());

  @override
  Stream<JournalState> mapEventToState(JournalEvent event) async* {
    if (event is LoadJournal) {
      yield* _mapLoadJournalToState();
    } else if (event is GetInitialList) {
      yield* _mapGetInitialListToState();
    } else if (event is LoadMore) {
      yield* _mapLoadMoretToState();
    } else if (event is LoadPrevious) {
      yield* _mapLoadPreviousToState();
    }
  }

  Stream<JournalState> _mapLoadJournalToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<JournalState> _mapGetInitialListToState() async* {
    List items = [];
    List currentList = [];
    List previousList = [];
    List<GlobalKey> _globalKey = [];
    String _year;
    String _month;

    DateTime now = DateTime.now();

    items = List<DateTime>.generate(100, (i) {
      return now.add(Duration(days: i));
    });

    currentList = items
        .where((item) =>
            DateFormat('MM').format(item) == DateFormat('MM').format(now))
        .toList();

    previousList = List.from(currentList);

    for (int i = 0; i < 100; i++) {
      _globalKey.add(GlobalKey());
    }

    _month = DateFormat('MM').format(now);
    _year = DateFormat('yyyy').format(now);

    yield state.update(
      isLoading: false,
      currentList: currentList,
      previousList: previousList,
      items: items,
      globalKey: _globalKey,
      year: _year,
      month: _month,
    );
  }

  Stream<JournalState> _mapLoadMoretToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<JournalState> _mapLoadPreviousToState() async* {
    yield state.update(isLoading: true);
  }
}
