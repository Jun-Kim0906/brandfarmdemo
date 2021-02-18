import 'dart:io';
import 'dart:typed_data';

import 'package:BrandFarm/blocs/journal_issue_create/bloc.dart';
import 'package:BrandFarm/blocs/journal_issue_modify/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> writeToFile(ByteData data, int i) async {
  final buffer = data.buffer;
  final String dttm = Timestamp.now().millisecondsSinceEpoch.toString();

  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var filePath = tempPath +
      '/file_0${dttm}.tmp'; // file_01.tmp is dump file, can be anything
  return File(filePath)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

Future getImage(
    {JournalIssueCreateState cstate,
      JournalIssueModifyState mstate,
    JournalIssueCreateBloc journalIssueCreateBloc,
      JournalIssueModifyBloc journalIssueModifyBloc,
    String from}) async {

  JournalIssueCreateBloc _journalIssueCreateBloc = journalIssueCreateBloc;
  JournalIssueModifyBloc _journalIssueModifyBloc = journalIssueModifyBloc;
  List<Asset> resultList = [];

  try {
    resultList =
        await MultiImagePicker.pickImages(maxImages: 10, enableCamera: true);
  } catch(e) {
    print(e);
  }

  switch (from) {
    case 'SubJournalIssueCreateScreen':
      {
        try {
          if (resultList.isNotEmpty) {
            _journalIssueCreateBloc.add(SelectImage(assetList: resultList));
            for (int i = 0; i < resultList.length; i++) {
              ByteData a = await resultList[i].getByteData();
              File file = await writeToFile(a, i);
              _journalIssueCreateBloc
                  .add(AddImageFile(imageFile: file, index: i));
            }
          }
        } catch (e) {
          print(e);
        }
      }
      break;
    case 'SubJournalIssueModifyScreen':
      {
        try {
          if (resultList.isNotEmpty) {
            _journalIssueModifyBloc.add(SelectImageM(assetList: resultList));
            for (int i = 0; i < resultList.length; i++) {
              ByteData a = await resultList[i].getByteData();
              File file = await writeToFile(a, i);
              _journalIssueModifyBloc
                  .add(AddImageFileM(imageFile: file, index: i));
            }
          }
        } catch (e) {
          print(e);
        }
      }
      break;
  }
}

Future getCameraImage(
    {JournalIssueCreateState cstate,
      JournalIssueModifyState mstate,
    JournalIssueCreateBloc journalIssueCreateBloc,
      JournalIssueModifyBloc journalIssueModifyBloc,
    String from}) async {
  JournalIssueCreateBloc _journalIssueCreateBloc = journalIssueCreateBloc;
  JournalIssueModifyBloc _journalIssueModifyBloc = journalIssueModifyBloc;
  PickedFile picked = await ImagePicker().getImage(source: ImageSource.camera);
  if (picked != null) {
    // File imageFile = File(picked.path);
    switch (from) {
      case 'SubJournalIssueCreateScreen':
        {
          // if (imageFile != null) {
          //   _journalIssueCreateBloc.add(AddImageFile(imageFile: imageFile,));
          // }
          _journalIssueCreateBloc.add(AddImageFile(
              imageFile: File(picked.path),
              from: 1,)
          );
        }
        break;
      case 'SubJournalIssueModifyScreen':
        {
          // if (imageFile != null) {
          //   _journalIssueCreateBloc.add(AddImageFile(imageFile: imageFile,));
          // }
          _journalIssueModifyBloc.add(AddImageFileM(
            imageFile: File(picked.path),
            from: 1,)
          );
        }
        break;
    }
  } else {
    print('No image selected');
  }
}
