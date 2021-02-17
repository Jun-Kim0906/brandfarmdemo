import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Profile {
  final String uid;
  final String profid;
  final String email;
  final String name;
  final int position;
  final String psw;
  final String imgUrl;
  final String addr;
  final String phone;

  Profile({
    @required this.email,
    @required this.profid,
    @required this.name,
    @required this.position,
    @required this.uid,
    @required this.psw,
    @required this.imgUrl,
    @required this.addr,
    @required this.phone,
  });

  factory Profile.fromSnapshot(DocumentSnapshot ds) {
    return Profile(
      email: ds['email'].toString(),
      profid: ds['profid'].toString(),
      name: ds['name'].toString(),
      position: ds['position'],
      uid: ds['uid'].toString(),
      psw: ds['psw'].toString(),
      imgUrl: ds['imgUrl'].toString(),
      addr: ds['addr'].toString(),
      phone: ds['phone'].toString(),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'email': email,
      'profid': profid,
      'name': name,
      'position': position,
      'uid': uid,
      'psw': psw,
      'imgUrl': imgUrl,
      'addr': addr,
      'phone': phone,
    };
  }
}
