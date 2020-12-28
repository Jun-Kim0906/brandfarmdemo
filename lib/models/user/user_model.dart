import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class User {
  final String uid;
  final String fcmToken;
  final String email;
  final String name;

  User({
    @required this.email,
    @required this.fcmToken,
    @required this.name,
    @required this.uid,
  });

  factory User.fromSnapshot(DocumentSnapshot ds) {
    return User(
      email: ds['email'],
      fcmToken: ds['fcmToken'],
      name: ds['name'],
      uid: ds['uid'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'email': email,
      'fcmToken': fcmToken,
      'name': name,
      'uid': uid,
    };
  }
}
