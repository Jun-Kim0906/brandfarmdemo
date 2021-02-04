import 'dart:io';

import 'package:BrandFarm/models/image/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageRepository{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference reference;

  Future<void> uploadImage({
    Image picture,
  }) async {
    DocumentReference reference = _firestore.collection('Picture').doc(picture.pid);
    await reference.set(picture.toMap());
  }

  Future<String> uploadImageFile(File file, String pid) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String url = '';

    final Reference ref = storage
        .ref()
        .child('journal_pictures')
        .child('tester')
        .child('$pid.jpg');
    // final UploadTask uploadTask = ref.putFile(file);

    await ref.getDownloadURL().then((value) => url = value);
    // await (await uploadTask.onComplete)
    //     .ref
    //     .getDownloadURL()
    //     .then((value) => url = value);

    return url;
  }
}