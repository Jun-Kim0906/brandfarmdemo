import 'package:BrandFarm/models/comment/comment_model.dart';

class CommentUtil {
  static Comment _cmt;
  static void setComment(Comment cmt) async {
    _cmt = cmt;
  }

  static Comment getComment() {
    return _cmt;
  }
}