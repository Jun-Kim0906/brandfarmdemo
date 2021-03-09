import 'package:BrandFarm/models/field_model.dart';
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FMIssueEvent extends Equatable{
  const FMIssueEvent();

  @override
  List<Object> get props => [];
}

class LoadFMIssueList extends FMIssueEvent {}

class GetIssueList extends FMIssueEvent {
  final Field field;

  const GetIssueList({
    @required this.field,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => '''GetIssueList { 
    field : $field,
  }''';
}

class SetIssYear extends FMIssueEvent {
  final String year;

  const SetIssYear({
    @required this.year,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'SetIssYear { year : $year}';
}

class SetIssMonth extends FMIssueEvent {
  final String month;

  const SetIssMonth({
    @required this.month,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'SetIssMonth { month : $month}';
}

class GetDetailUserInfo extends FMIssueEvent {
  final String sfmid;

  const GetDetailUserInfo({
    @required this.sfmid,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'GetDetailUserInfo { sfmid : $sfmid}';
}

class CheckAsRead extends FMIssueEvent {
  final SubJournalIssue obj;
  final int index;
  final String order;

  const CheckAsRead({
    @required this.obj,
    @required this.index,
    @required this.order,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => '''CheckAsRead { 
    obj : $obj,
    index : $index,
    order : $order,
  }''';
}

class GetCommentList extends FMIssueEvent {
  final SubJournalIssue obj;

  const GetCommentList({
    @required this.obj,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'GetCommentList { obj : $obj}';
}

class ChangeExpandState extends FMIssueEvent {
  final int index;

  const ChangeExpandState({
    @required this.index,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'ChangeExpandState { index : $index}';
}