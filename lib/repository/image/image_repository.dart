import 'dart:io';

import 'package:BrandFarm/models/image_picture/image_picture_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../utils/user/user_util.dart';

class ImageRepository{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference reference;

  Future<void> uploadImage({
    ImagePicture picture,
  }) async {
    DocumentReference reference = _firestore.collection('Picture').doc(picture.pid);
    await reference.set(picture.toMap());
  }

  Future<String> uploadImageFile(File file, String pid) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    var url;
    final Reference ref = storage
        .ref()
        .child('issue')
        .child(UserUtil.getUser().uid)
        .child('$pid.jpg');
    final UploadTask uploadTask = ref.putFile(file);

    await (await uploadTask)
        .ref
        .getDownloadURL()
        .then((value) => url = value);

    return url;
  }

  Future<String> uploadJournalImageFile(File file, String pid) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    var url;
    final Reference ref = storage
        .ref()
        .child('journal')
        .child(UserUtil.getUser().uid)
        .child('$pid.jpg');
    final UploadTask uploadTask = ref.putFile(file);

    await (await uploadTask)
        .ref
        .getDownloadURL()
        .then((value) => url = value);

    return url;
  }

  Future<void> deleteFromStorage({ImagePicture pic}) async {
    // delete from storage
    Reference photoRef = await FirebaseStorage.instance.refFromURL(pic.url);
    await photoRef.delete();
  }

  Future<void> deleteFromDatabase({ImagePicture pic}) async {
    // delete from database
    await FirebaseFirestore.instance
        .collection('Picture')
        .doc(pic.pid)
        .delete();
  }
}