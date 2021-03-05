import 'package:BrandFarm/models/field_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FMJournalEvent extends Equatable{
  const FMJournalEvent();

  @override
  List<Object> get props => [];
}

class LoadFMJournalList extends FMJournalEvent {}

class ChangeScreen extends FMJournalEvent {
  final int navTo;

  const ChangeScreen({
    @required this.navTo,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'ChangeScreen { navTo : $navTo}';
}

class ChangeSwitchState extends FMJournalEvent {}

class GetFieldList extends FMJournalEvent {}

class SetField extends FMJournalEvent {
  final Field field;

  const SetField({
    @required this.field,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'SetField { field : $field}';
}

class SetJourYear extends FMJournalEvent {
  final String year;

  const SetJourYear({
    @required this.year,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'SetJourYear { year : $year}';
}

class SetJourMonth extends FMJournalEvent {
  final String month;

  const SetJourMonth({
    @required this.month,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'SetJourMonth { month : $month}';
}