import 'package:BrandFarm/blocs/comment/bloc.dart';
import 'package:BrandFarm/models/comment/comment_model.dart';
import 'package:BrandFarm/repository/comment/comment_repository.dart';
import 'package:BrandFarm/utils/comment/comment_util.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentState.empty());

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is LoadComment) {
      yield* _mapLoadCommentToState();
    } else if (event is GetComment) {
      yield* _mapGetCommentToState(issid: event.issid);
    } else if (event is AddComment) {
      yield* _mapAddCommentToState(
          from: event.from,
          id: event.id,
          comment: event.comment);
    } else if (event is AddSubComment) {
      yield* _mapAddSubCommentToState(
          from: event.from,
          id: event.id,
          comment: event.comment,
          cmtid: event.cmtid);
    } else if (event is ExpandComment) {
      yield* _mapExpandCommentToState(index: event.index);
    } else if (event is CloseComment) {
      yield* _mapCloseCommentToState(index: event.index);
    }
  }

  Stream<CommentState> _mapLoadCommentToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<CommentState> _mapGetCommentToState({String issid}) async* {
    List comments = [];
    List scomments = [];

    QuerySnapshot _cmt = await FirebaseFirestore.instance
        .collection('Comment')
        .where('issid', isEqualTo: issid)
        .orderBy('date', descending: true)
        .get();

    _cmt.docs.forEach((ds) {
      comments.add(Comment.fromSnapshot(ds));
    });

    // await Future.forEach(_cmt.docs, (ds) async {
    //   comments.add(Comment.fromSnapshot(ds));
    // });

    QuerySnapshot _scmt = await FirebaseFirestore.instance
        .collection('SubComment')
        .where('issid', isEqualTo: issid)
        .orderBy('date', descending: true)
        .get();

    _scmt.docs.forEach((ds) {
      scomments.add(SubComment.fromSnapshot(ds));
    });

    // await Future.forEach(_scmt.docs, (ds) async {
    //   scomments.add(SubComment.fromSnapshot(ds));
    // });

    print('${comments.length}');
    print('${scomments.length}');

    yield state.update(
      isLoading: false,
      comments: comments,
      scomments: scomments,
    );
  }

  Stream<CommentState> _mapAddCommentToState(
      {String from, String id, String comment}) async* {
    List comments = [];

    comments = state.comments;

    if (from == 'journal') {
      String cmtid = '';
      cmtid = FirebaseFirestore.instance.collection('Comment').doc().id;
      Comment cmt = Comment(
        date: Timestamp.now(),
        jid: id,
        uid: UserUtil.getUser().uid ?? '--',
        issid: '--',
        cmtid: cmtid,
        name: UserUtil.getUser().name,
        comment: comment,
        isThereSubComment: false,
        isExpanded: false,
      );

      await CommentRepository().uploadComment(comment: cmt);

      comments.add(cmt);
    } else {
      String cmtid = '';
      cmtid = FirebaseFirestore.instance.collection('Comment').doc().id;
      Comment cmt = Comment(
        date: Timestamp.now(),
        jid: '--',
        uid: UserUtil.getUser().uid ?? '--',
        issid: id,
        cmtid: cmtid,
        name: UserUtil.getUser().name,
        comment: comment,
        isThereSubComment: false,
        isExpanded: false,
      );

      await CommentRepository().uploadComment(comment: cmt);

      comments.add(cmt);
    }

    yield state.update(
      isLoading: false,
      comments: comments,
    );
  }

  Stream<CommentState> _mapAddSubCommentToState(
      {String from, String id, String comment, String cmtid}) async* {
    List scomments = [];

    scomments = state.scomments;

    if (from == 'journal') {
      String scmtid = '';
      scmtid = FirebaseFirestore.instance.collection('SubComment').doc().id;
      SubComment scmt = SubComment(
        date: Timestamp.now(),
        jid: id,
        uid: UserUtil.getUser().uid ?? '--',
        issid: '--',
        scmtid: scmtid,
        cmtid: cmtid,
        name: UserUtil.getUser().name,
        scomment: comment,
      );

      await CommentRepository().uploadSubComment(scomment: scmt);
      await CommentRepository().updateComment(isThereSubComment: true);

      scomments.add(scmt);
    } else {
      String scmtid = '';
      scmtid = FirebaseFirestore.instance.collection('SubComment').doc().id;
      SubComment scmt = SubComment(
        date: Timestamp.now(),
        jid: '--',
        uid: UserUtil.getUser().uid ?? '--',
        issid: id,
        scmtid: scmtid,
        cmtid: cmtid,
        name: UserUtil.getUser().name,
        scomment: comment,
      );

      await CommentRepository().uploadSubComment(scomment: scmt);
      await CommentRepository().updateComment(isThereSubComment: true);

      scomments.add(scmt);
    }

    yield state.update(
      isLoading: false,
      scomments: scomments,
    );
  }

  Stream<CommentState> _mapExpandCommentToState({int index}) async* {
    List cmts = [];
    cmts = state.comments;

    CommentUtil.setComment(Comment(
      date: cmts[index].date,
      name: cmts[index].name,
      uid: cmts[index].uid,
      issid: cmts[index].issid,
      jid: cmts[index].jid,
      cmtid: cmts[index].cmtid,
      comment: cmts[index].comment,
      isThereSubComment: cmts[index].isThereSubComment,
      isExpanded: true,
    ));

    cmts.removeAt(index);
    cmts.insert(index, CommentUtil.getComment());

    yield state.update(
        comments: cmts,
    );
  }

  Stream<CommentState> _mapCloseCommentToState({int index}) async* {
    List cmts = [];
    cmts = state.comments;

    await CommentUtil.setComment(Comment(
      date: cmts[index].date,
      name: cmts[index].name,
      uid: cmts[index].uid,
      issid: cmts[index].issid,
      jid: cmts[index].jid,
      cmtid: cmts[index].cmtid,
      comment: cmts[index].comment,
      isThereSubComment: cmts[index].isThereSubComment,
      isExpanded: false,
    ));

    cmts.removeAt(index);
    cmts.insert(index, await CommentUtil.getComment());

    yield state.update(
        comments: cmts,
    );
  }
}
