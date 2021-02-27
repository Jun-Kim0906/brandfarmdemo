
import 'package:BrandFarm/models/comment/comment_model.dart';
import 'package:BrandFarm/models/user/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommentState {
  final bool isLoading;

  final List<Comment> comments;
  final List<SubComment> subComments;

  final List<User> commentsUser;
  final List<User> subCommentsUser;

  CommentState({
    @required this.isLoading,
    @required this.comments,
    @required this.subComments,
    @required this.commentsUser,
    @required this.subCommentsUser,
  });

  factory CommentState.empty() {
    return CommentState(
      isLoading: false,
      comments: [],
      subComments: [],
      commentsUser: [],
      subCommentsUser: [],
    );
  }

  CommentState copyWith({
    bool isLoading,
    List<Comment> comments,
    List<SubComment> subComments,
    List<User> commentsUser,
    List<User> subCommentsUser,
  }) {
    return CommentState(
      isLoading: isLoading ?? this.isLoading,
      comments: comments ?? this.comments,
      subComments: subComments ?? this.subComments,
      commentsUser: commentsUser ?? this.commentsUser,
      subCommentsUser: subCommentsUser ?? this.subCommentsUser,
    );
  }

  CommentState update({
    bool isLoading,
    List<Comment> comments,
    List<SubComment> subComments,
    List<User> commentsUser,
    List<User> subCommentsUser,
  }) {
    return copyWith(
      isLoading: isLoading,
      comments: comments,
      subComments: subComments,
      commentsUser: commentsUser,
      subCommentsUser: subCommentsUser,
    );
  }

  @override
  String toString() {
    return '''CommentState{
    isLoading: $isLoading,
    comments: $comments,
    subComments: $subComments,
    commentsUser: $commentsUser,
    subCommentsUser: $subCommentsUser,
    }
    ''';
  }
}
