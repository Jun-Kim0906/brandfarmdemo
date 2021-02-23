import 'dart:io';

import 'package:BrandFarm/models/user/user_model.dart';
import 'package:BrandFarm/repository/user/user_repository.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ProfileRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadProfile() async {
    DocumentReference reference =
    _firestore.collection('User').doc(UserUtil.getUser().uid);
    await reference.set(UserUtil.getUser().toDocument());
  }

  Future<void> updateProfile() async {
    DocumentReference reference =
    _firestore.collection('User').doc(UserUtil.getUser().uid);
    await reference.update(UserUtil.getUser().toDocument());
  }

  Future<void> updatePassword({String prev}) async {
    DocumentReference reference =
    _firestore.collection('User').doc(UserUtil.getUser().uid);
    await reference.update(UserUtil.getUser().toDocument());

    await UserRepository().resetPassword(changed: UserUtil.getUser().psw, prev: prev);
  }

  Future<User> getProfile() async {
    User user;
    await FirebaseFirestore.instance
        .collection('User')
        .where('uid', isEqualTo: UserUtil.getUser().uid)
        .get()
        .then((qs) {
      qs.docs.forEach((ds) {
        user = User.fromSnapshot(ds);
      });
    });
    return user;
  }

  Future<void> updateImage() async {

    DocumentReference reference =
    _firestore.collection('User').doc(UserUtil.getUser().uid);
    await reference.update(UserUtil.getUser().toDocument());
  }

  Future<String> uploadImageToStorage(File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    var url;
    final Reference ref = storage
        .ref()
        .child('profile')
        .child(UserUtil.getUser().uid)
        .child('${UserUtil.getUser().uid}.jpg');
    final UploadTask uploadTask = ref.putFile(file);

    await (await uploadTask)
        .ref
        .getDownloadURL()
        .then((value) => url = value);

    return url;
  }
}