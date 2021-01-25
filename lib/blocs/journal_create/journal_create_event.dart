
import 'package:equatable/equatable.dart';

abstract class JournalCreateEvent extends Equatable{
  const JournalCreateEvent();

  @override
  List<Object> get props => [];
}

class ExampleEvent extends JournalCreateEvent{}