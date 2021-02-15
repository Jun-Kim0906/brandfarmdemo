
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommentState {
  final bool isLoading;

  final List comments;
  final List scomments;

  CommentState({
    @required this.isLoading,
    @required this.comments,
    @required this.scomments,
  });

  factory CommentState.empty() {
    return CommentState(
      isLoading: false,
      comments: [],
      scomments: [],
    );
  }

  CommentState copyWith({
    bool isLoading,
    List comments,
    List scomments,
  }) {
    return CommentState(
      isLoading: isLoading ?? this.isLoading,
      comments: comments ?? this.comments,
      scomments: scomments ?? this.scomments,
    );
  }

  CommentState update({
    bool isLoading,
    List comments,
    List scomments,
  }) {
    return copyWith(
      isLoading: isLoading,
      comments: comments,
      scomments: scomments,
    );
  }

  @override
  String toString() {
    return '''CommentState{
    isLoading: $isLoading,
    comments: $comments,
    scomments: $scomments,
    }
    ''';
  }
}
