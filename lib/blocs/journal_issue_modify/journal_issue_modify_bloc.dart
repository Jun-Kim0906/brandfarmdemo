import 'dart:io';

import 'package:BrandFarm/blocs/journal_issue_modify/bloc.dart';
import 'package:BrandFarm/models/image_picture/image_picture_model.dart';
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';
import 'package:BrandFarm/repository/image/image_repository.dart';
import 'package:BrandFarm/utils/resize_image.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:BrandFarm/repository/sub_journal/sub_journal_repository.dart';

class JournalIssueModifyBloc
    extends Bloc<JournalIssueModifyEvent, JournalIssueModifyState> {
  JournalIssueModifyBloc() : super(JournalIssueModifyState.empty());

  @override
  Stream<JournalIssueModifyState> mapEventToState(
      JournalIssueModifyEvent event) async* {
    if (event is AddImageFileM) {
      yield* _mapAddImageFileMToState(
          imageFile: event.imageFile, index: event.index, from: event.from);
    } else if (event is SelectImageM) {
      yield* _mapSelectImageMToState(assetList: event.assetList);
    } else if (event is PressComplete) {
      yield* _mapPressCompleteToState();
    } else if (event is DeleteImageFile) {
      yield* _mapDeleteImageFileToState(removedFile: event.removedFile);
    } else if (event is UpdateJournal) {
      yield* _mapUpdateJournalToState(
        fid: event.fid,
        sfmid: event.sfmid,
        uid: event.uid,
        title: event.title,
        category: event.category,
        issueState: event.issueState,
        contents: event.contents,
        issid: event.issid,
        comments: event.comments,
      );
    } else if (event is GetImageList) {
      yield* _mapGetImageListToState(
        issid: event.issid,
      );
    } else if (event is DeleteExistingImage) {
      yield* _mapDeleteExistingImageToState(obj: event.obj);
    }
  }

  Stream<JournalIssueModifyState> _mapAddImageFileMToState(
      {File imageFile, int index, int from}) async* {
    List<File> _img = state.imageList;

    if (!_img.contains(imageFile) && from == 0) {
      _img.removeAt(index);
      _img.insert(index, await resizeImage(imageFile));
    }
    if (from == 1) {
      _img.add(await resizeImage(imageFile));
    }

    yield state.update(
      imageList: _img,
    );
  }

  Stream<JournalIssueModifyState> _mapSelectImageMToState(
      {List<Asset> assetList}) async* {
    List<File> bufferList = state.imageList;
    for (int i = 0; i < assetList.length; i++) {
      bufferList.insert(0, null);
    }
    yield state.update(assetList: assetList, imageList: bufferList);
  }

  Stream<JournalIssueModifyState> _mapPressCompleteToState() async* {
    yield state.update(
      isComplete: true,
    );
  }

  Stream<JournalIssueModifyState> _mapDeleteImageFileToState(
      {File removedFile}) async* {
    List<File> _img = state.imageList;
    _img.remove(removedFile);

    yield state.update(
      imageList: _img,
    );
  }

  Stream<JournalIssueModifyState> _mapUpdateJournalToState(
      {String fid,
        String sfmid,
        String uid,
        String title,
        int category,
        int issueState,
        String issid,
        String contents,
        int comments,}) async* {
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    if(state.deletedFromExistingImageList.isNotEmpty){
      await Future.forEach(state.deletedFromExistingImageList, (pic) async {
        await ImageRepository().deleteFromStorage(pic: pic);
        await ImageRepository().deleteFromDatabase(pic: pic);
      });
    }

    SubJournalIssue subJournalIssue = SubJournalIssue(
      date: Timestamp.now(),
      fid: fid ?? '--',
      sfmid: sfmid ?? '--',
      issid: issid ?? '--',
      uid: uid ?? '--',
      title: title,
      category: category,
      issueState: issueState,
      contents: contents,
      comments: comments ?? 0,
    );

    await SubJournalRepository()
        .updateIssue(subJournalIssue: subJournalIssue);

    List<File> imageList = state.imageList;
    String pid = '';

    if (imageList.isNotEmpty) {
      await Future.forEach(imageList, (File file) async {
        pid = FirebaseFirestore.instance.collection('Picture').doc().id;
        ImagePicture _picture = ImagePicture(
          fid: subJournalIssue.fid,
          jid: subJournalIssue.sfmid,
          uid: UserUtil.getUser().uid,
          issid: subJournalIssue.issid,
          pid: pid,
          url: (await ImageRepository().uploadImageFile(file, pid)),
          dttm: Timestamp.now(),
        );

        await ImageRepository().uploadImage(
          picture: _picture,
        );
      });
    }

    yield state.update(
      isUploaded: true,
    );
  }

  Stream<JournalIssueModifyState> _mapGetImageListToState({String issid}) async* {
    List<ImagePicture> img = [];

    QuerySnapshot pic = await FirebaseFirestore.instance
        .collection('Picture')
        .where('uid', isEqualTo: UserUtil.getUser().uid)
        .orderBy('dttm', descending: true)
        .get();
    pic.docs.forEach((ds) {
      img.add(ImagePicture.fromSnapshot(ds));
    });

    yield state.update(
      existingImageList: img,
    );
  }

  Stream<JournalIssueModifyState> _mapDeleteExistingImageToState({ImagePicture obj}) async* {
    List<ImagePicture> img = [];
    img = state.deletedFromExistingImageList;

    // delete from bloc state list
    int index = state.existingImageList.indexWhere((element) => element.pid == obj.pid);
    if(img.isNotEmpty) {
      img.add(state.existingImageList[index]);
    } else {
      img.removeAt(0);
      img.insert(index, state.existingImageList[index]);
    }
    
    yield state.update(
      deletedFromExistingImageList: img,
    );
  }
}
