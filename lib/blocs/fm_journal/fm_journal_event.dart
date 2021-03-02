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

  @override
  List<Object> get props => [navTo];

  @override
  String toString() => 'ChangeScreen { navTo : $navTo}';
}