import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadComment extends CommentEvent {}

class GetComment extends CommentEvent {
  final String issid;

  const GetComment({
    @required this.issid,
  });

  @override
  List<Object> get props => [issid];

  @override
  String toString() => 'GetComment { issid: $issid, }';
}

class AddComment extends CommentEvent {
  final String from;
  final String id;
  final String comment;

  const AddComment({
    @required this.from,
    @required this.id,
    @required this.comment,
  });

  @override
  List<Object> get props => [
    from,
    id,
    comment,
  ];

  @override
  String toString() => '''AddComment { 
    from: $from, 
    id: $id, 
    comment: $comment, 
  }''';
}

class AddSubComment extends CommentEvent {
  final String from;
  final String id;
  final String cmtid;
  final String comment;

  const AddSubComment({
    @required this.from,
    @required this.id,
    @required this.cmtid,
    @required this.comment,
  });

  @override
  List<Object> get props => [
    from,
    id,
    cmtid,
    comment,
  ];

  @override
  String toString() => '''AddSubComment { 
    from: $from, 
    id: $id, 
    cmtid: $cmtid, 
    comment: $comment, 
  }''';
}

class ExpandComment extends CommentEvent {
  final int index;

  const ExpandComment({
    @required this.index,
  });

  @override
  List<Object> get props => [
    index,
  ];

  @override
  String toString() => '''ExpandComment { 
    index: $index, 
  }''';
}

class CloseComment extends CommentEvent {
  final int index;

  const CloseComment({
    @required this.index,
  });

  @override
  List<Object> get props => [
    index,
  ];

  @override
  String toString() => '''CloseComment { 
    index: $index, 
  }''';
}