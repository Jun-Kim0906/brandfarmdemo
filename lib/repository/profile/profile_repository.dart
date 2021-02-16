import 'package:BrandFarm/models/profile/profile_model.dart';
import 'package:BrandFarm/repository/user/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadProfile({
    Profile profile,
  }) async {
    DocumentReference reference =
    _firestore.collection('Profile').doc(profile.profid);
    await reference.set(profile.toDocument());
  }

  Future<void> updateProfile({
    Profile profile,
  }) async {
    DocumentReference reference =
    _firestore.collection('Profile').doc(profile.profid);
    await reference.update(profile.toDocument());

    DocumentReference user =
    _firestore.collection('User').doc(profile.uid);
    await user.update({"psw":profile.psw});

    await UserRepository().resetPassword(psw: profile.psw);
  }

  Future<Profile> getProfile({
    String uid,
  }) async {
    Profile profile;
    await FirebaseFirestore.instance
        .collection('Profile')
        .where('uid', isEqualTo: uid)
        .get()
        .then((qs) {
      qs.docs.forEach((ds) {
        profile = Profile.fromSnapshot(ds);
      });
    });
    return profile;
  }
}