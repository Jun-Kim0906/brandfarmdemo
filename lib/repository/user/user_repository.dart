import 'dart:async';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String id, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: id,
      password: password,
    );
  }

  Future<void> signUp({String id, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: id,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getUser() async {
    return (_firebaseAuth.currentUser);
  }

  Future<void> resetPassword({String changed, String prev}) async {
    final currentUser = await _firebaseAuth.currentUser;
    UserCredential authResult = await currentUser.reauthenticateWithCredential(
       EmailAuthProvider.credential(
         email: await UserUtil.getUser().id,
         password: prev,
       ),
    );
    await authResult.user.updatePassword(changed).then((_) {
      print('Successfully changed password');
    }).catchError((error) {
      print("Password can't be changed: " + error.toString());
    });
  }
}
