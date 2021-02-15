import 'package:BrandFarm/models/comment/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadComment({
    Comment comment,
  }) async {
    DocumentReference reference =
    _firestore.collection('Comment').doc(comment.cmtid);
    await reference.set(comment.toDocument());
  }

  Future<void> uploadSubComment({
    SubComment scomment,
  }) async {
    DocumentReference reference =
    _firestore.collection('SubComment').doc(scomment.scmtid);
    await reference.set(scomment.toDocument());
  }

  Future<void> updateComment({
    bool isThereSubComment, String cmtid
  }) async {
    DocumentReference reference =
    _firestore.collection('Comment').doc(cmtid);
    await reference.update({"isThereSubComment":isThereSubComment});
  }
}