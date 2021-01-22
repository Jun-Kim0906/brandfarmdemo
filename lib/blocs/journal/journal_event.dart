import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class JournalEvent extends Equatable{
  const JournalEvent();

  @override
  List<Object> get props => [];
}

class LoadJournal extends JournalEvent {}

class GetInitialList extends JournalEvent {}

class LoadMore extends JournalEvent {}

class LoadPrevious extends JournalEvent {}