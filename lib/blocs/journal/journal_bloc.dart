import 'package:BrandFarm/blocs/journal/bloc.dart';
import 'package:BrandFarm/models/image_picture/image_picture_model.dart';
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';
import 'package:BrandFarm/repository/sub_journal/sub_journal_repository.dart';
import 'package:BrandFarm/utils/issue/issue_util.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
    } else if (event is AddIssueComment) {
      yield* _mapAddIssueCommentToState(
          index: event.index,
          issueListOptions: event.issueListOptions,
          issueOrder: event.issueOrder,
          issid: event.issid,);
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
    List imageList = [];

    // get journal list
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    orderByRecent = await SubJournalRepository().getJournal();
    orderByOldest = List.from(orderByRecent.reversed);

    // get issue list
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    issueList = await SubJournalRepository().getIssue();
    reverseIssueList = List.from(issueList.reversed);

    // get image
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    imageList = await SubJournalRepository().getImage();

    yield state.update(
      isLoading: false,
      orderByOldest: orderByOldest,
      orderByRecent: orderByRecent,
      issueList: issueList,
      reverseIssueList: reverseIssueList,
      imageList: imageList,
    );
  }

  Stream<JournalState> _mapGetListBySelectedDateToState(
      {String month, String year}) async* {
    List listBySelection = [];
    List fromExistingList = state.orderByRecent;

    listBySelection = fromExistingList
        .where((element) =>
            DateFormat('yyyy-MM').format(DateTime.fromMicrosecondsSinceEpoch(
                element.date.microsecondsSinceEpoch)) ==
            '${year}-${month}')
        .toList();

    yield state.update(
      isLoading: false,
      listBySelection: listBySelection,
    );
  }

  Stream<JournalState> _mapGetIssueListByTimeOrderToState(
      {String issueListOption, String issueListOrderOption}) async* {
    List reverseIssueList = [];

    if (issueListOption == '전체') {
      reverseIssueList = state.issueList;
      reverseIssueList = List.from(reverseIssueList.reversed);
    } else {
      reverseIssueList = state.issueListByCategorySelection;
      reverseIssueList = List.from(reverseIssueList.reversed);
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
      currentImageList = state.imageList;
      int length1 = state.issueList.length - 1;
      int length2 = state.imageList.length - 1;

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
          .where('dttm', isLessThan: state.imageList[length2].dttm)
          .orderBy('dttm', descending: true)
          .get();
      pic.docs.forEach((ds) {
        newImageList.add(ImagePicture.fromSnapshot(ds));
      });

      combinedList = [...currentList, ...newList];
      combinedImageList = [...currentImageList, ...newImageList];
      for (int i = combinedList.length - 1; i >= 0; i--) {
        reverseList.add(combinedList[i]);
      }

      yield state.update(
        isLoadingToGetMore: false,
        issueList: combinedList,
        imageList: combinedImageList,
        reverseIssueList: reverseList,
      );
    }
  }

  Stream<JournalState> _mapWaitForLoadMoreToState() async* {
    yield state.update(isLoadingToGetMore: true);
  }

  Stream<JournalState> _mapAddIssueCommentToState({
    int index, String issueListOptions, int issueOrder, String issid}) async* {

    List issue = state.issueList;
    List cat = state.issueListByCategorySelection;
    List rev = state.reverseIssueList;

    int index1 = issue.indexWhere((data) => data.issid == issid) ?? -1;
    int index2 = cat.indexWhere((data) => data.issid == issid) ?? -1;
    int index3 = rev.indexWhere((data) => data.issid == issid) ?? -1;

    await SubJournalRepository().updateIssueComment(
        issid: issid, cmts: issue[index1].comments + 1);

    await IssueUtil.setIssue(SubJournalIssue(
      category: issue[index1].category,
      comments: issue[index1].comments + 1,
      contents: issue[index1].contents,
      date: issue[index1].date,
      fid: issue[index1].fid,
      uid: issue[index1].uid,
      sfmid: issue[index1].sfmid,
      issid: issue[index1].issid,
      title: issue[index1].title,
      issueState: issue[index1].issueState,
    ));

    if(index1 != -1) {
      issue.removeAt(index1);
      issue.insert(index1, await IssueUtil.getIssue());
    }
    if(index2 != -1) {
      cat.removeAt(index2);
      cat.insert(index2, await IssueUtil.getIssue());
    }
    if(index3 != -1) {
      rev.removeAt(index3);
      rev.insert(index3, await IssueUtil.getIssue());
    }

    yield state.update(
      issueList: issue,
      issueListByCategorySelection: cat,
      reverseIssueList: rev,
    );
  }
}
