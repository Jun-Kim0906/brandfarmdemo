import 'package:BrandFarm/blocs/journal/bloc.dart';
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../models/image/image_model.dart';
import '../../utils/user/user_util.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  JournalBloc() : super(JournalState.empty());

  DateTime now = DateTime.now();

  @override
  Stream<JournalState> mapEventToState(JournalEvent event) async* {
    if (event is LoadJournal) {
      yield* _mapLoadJournalToState();
    } else if (event is GetInitialList) {
      yield* _mapGetInitialListToState();
    } else if (event is GetListBySelectedDate) {
      yield* _mapGetListBySelectedDateToState(
          month: event.month, year: event.year);
    } else if (event is LoadMore) {
      yield* _mapLoadMoretToState(tab: event.tab);
    } else if (event is GetIssueListByTimeOrder) {
      yield* _mapGetIssueListByTimeOrderToState(
          issueListOption: event.issueListOption,
          issueListOrderOption: event.issueListOrderOption);
    } else if (event is GetIssueListByCategory) {
      yield* _mapGetIssueListByCategoryToState(issueState: event.issueState);
    } else if (event is WaitForLoadMore) {
      yield* _mapWaitForLoadMoreToState();
    }
  }

  Stream<JournalState> _mapLoadJournalToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<JournalState> _mapGetInitialListToState() async* {
    List orderByRecent = [];
    List orderByOldest = [];
    List issueList = [];
    List reverseIssueList = [];
    List issueImageList = [];

    orderByRecent = List<DateTime>.generate(100, (i) {
      return now.add(Duration(days: i));
    });

    for (int i = orderByRecent.length - 1; i >= 0; i--) {
      orderByOldest.add(orderByRecent[i]);
    }

    // Issue State
    // 예상 1
    // 진행 2
    // 완료 3
    // issueList = List<IssueItem>.generate(20, (i) {
    //   if(i < 10) {
    //     return IssueItem(date: now.add(Duration(days: i)), issueState: 1);
    //   } else if(i > 9 && i < 15) {
    //     return IssueItem(date: now.add(Duration(days: i)), issueState: 2);
    //   } else{
    //     return IssueItem(date: now.add(Duration(days: i)), issueState: 3);
    //   }
    //   // return now.add(Duration(days: i));
    // });

    // for (int i = issueList.length - 1; i >= 0; i--) {
    //   reverseIssueList.add(issueList[i]);
    // }

    QuerySnapshot _issue = await FirebaseFirestore.instance
        .collection('Issue')
        .where('uid', isEqualTo: UserUtil.getUser().uid)
        .orderBy('date', descending: true)
        .limit(20)
        .get();

    _issue.docs.forEach((ds) {
      issueList.add(SubJournalIssue.fromSnapshot(ds));
    });

    for (int i = issueList.length - 1; i >= 0; i--) {
      reverseIssueList.add(issueList[i]);
    }

    QuerySnapshot pic = await FirebaseFirestore.instance
        .collection('Picture')
        .where('uid', isEqualTo: UserUtil.getUser().uid)
        .orderBy('dttm', descending: true)
        .get();
    pic.docs.forEach((ds) {
      issueImageList.add(Image.fromSnapshot(ds));
    });

    yield state.update(
      isLoading: false,
      orderByOldest: orderByOldest,
      orderByRecent: orderByRecent,
      issueList: issueList,
      reverseIssueList: reverseIssueList,
      issueImageList: issueImageList,
    );
  }

  Stream<JournalState> _mapGetListBySelectedDateToState(
      {String month, String year}) async* {
    List listBySelection = [];
    List fromExistingList = state.orderByRecent;

    listBySelection = fromExistingList
        .where((element) =>
            DateFormat('yyyy-MM').format(DateTime.fromMicrosecondsSinceEpoch(
                element.microsecondsSinceEpoch)) ==
            '${year}-${month}')
        .toList();

    yield state.update(
      isLoading: false,
      listBySelection: listBySelection,
    );
  }

  Stream<JournalState> _mapGetIssueListByTimeOrderToState(
      {String issueListOption, String issueListOrderOption}) async* {
    List getList = [];
    List reverseIssueList = [];

    if (issueListOption == '전체') {
      getList = state.issueList;
      for (int i = getList.length - 1; i >= 0; i--) {
        // print(DateFormat('yyyy-MM-dd').format(DateTime.fromMicrosecondsSinceEpoch(
        //     getList[i].date.microsecondsSinceEpoch)));
        // print(getList[i].issueState);
        reverseIssueList.add(getList[i]);
      }
    } else {
      getList = state.issueListByCategorySelection;
      for (int i = getList.length - 1; i >= 0; i--) {
        // print(DateFormat('yyyy-MM-dd').format(DateTime.fromMicrosecondsSinceEpoch(
        //     getList[i].date.microsecondsSinceEpoch)));
        // print(getList[i].issueState);
        reverseIssueList.add(getList[i]);
      }
    }

    yield state.update(
      isLoading: false,
      reverseIssueList: reverseIssueList,
    );
  }

  Stream<JournalState> _mapGetIssueListByCategoryToState(
      {int issueState}) async* {
    List issueListByCategorySelection = [];

    // print(issueState);

    issueListByCategorySelection = state.issueList.where((element) {
      // print(element.issueState);
      return element.issueState == issueState;
    }).toList();

    // issueListByCategorySelection.forEach((element) => print(element.title));

    yield state.update(
      isLoading: false,
      issueListByCategorySelection: issueListByCategorySelection,
    );
  }

  Stream<JournalState> _mapLoadMoretToState({int tab}) async* {
    List currentList = [];
    List newList = [];
    List currentImageList = [];
    List newImageList = [];
    List combinedList = [];
    List combinedImageList = [];
    List reverseList = [];

    if (tab == 0) {
      currentList = state.orderByRecent;
      newList = List<DateTime>.generate(100, (i) {
        return now.add(Duration(days: i + 100));
      });

      yield state.update(
        isLoadingToGetMore: false,
        orderByRecent: [...currentList, ...newList],
      );
    } else {
      currentList = state.issueList;
      currentImageList = state.issueImageList;
      int length1 = state.issueList.length - 1;
      int length2 = state.issueImageList.length - 1;

      QuerySnapshot _issue = await FirebaseFirestore.instance
          .collection('Issue')
          .where('uid', isEqualTo: UserUtil.getUser().uid)
          .where('date', isLessThan: state.issueList[length1].date)
          .orderBy('date', descending: true)
          .limit(20)
          .get();

      _issue.docs.forEach((ds) {
        newList.add(SubJournalIssue.fromSnapshot(ds));
      });

      QuerySnapshot pic = await FirebaseFirestore.instance
          .collection('Picture')
          .where('uid', isEqualTo: UserUtil.getUser().uid)
          .where('dttm', isLessThan: state.issueImageList[length2].dttm)
          .orderBy('dttm', descending: true)
          .get();
      pic.docs.forEach((ds) {
        newImageList.add(Image.fromSnapshot(ds));
      });

      combinedList = [...currentList, ...newList];
      combinedImageList = [...currentImageList, ...newImageList];
      for (int i = combinedList.length - 1; i >= 0; i--) {
        reverseList.add(combinedList[i]);
      }

      yield state.update(
        isLoadingToGetMore: false,
        issueList: combinedList,
        issueImageList: combinedImageList,
        reverseIssueList: reverseList,
      );
    }
  }

  Stream<JournalState> _mapWaitForLoadMoreToState() async* {
    yield state.update(isLoadingToGetMore: true);
  }
}
