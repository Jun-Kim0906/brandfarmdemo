import 'package:equatable/equatable.dart';

abstract class FMIssueEvent extends Equatable{
  const FMIssueEvent();

  @override
  List<Object> get props => [];
}

class LoadFMIssueList extends FMIssueEvent {}