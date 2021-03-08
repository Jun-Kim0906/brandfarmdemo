import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FMIssueEvent extends Equatable{
  const FMIssueEvent();

  @override
  List<Object> get props => [];
}

class LoadFMIssueList extends FMIssueEvent {}

class GetIssueList extends FMIssueEvent {
  final String fid;

  const GetIssueList({
    @required this.fid,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'GetIssueList { fid : $fid}';
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