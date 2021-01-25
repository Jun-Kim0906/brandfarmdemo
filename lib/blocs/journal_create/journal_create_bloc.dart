import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:bloc/bloc.dart';

class JournalCreateBloc extends Bloc<JournalCreateEvent, JournalCreateState>{
  JournalCreateBloc(): super(JournalCreateState.empty());

  @override
  Stream<JournalCreateState> mapEventToState(JournalCreateEvent event) async* {
    if(event is ExampleEvent){
      yield* _mapExampleEventToState();
    }
  }

  Stream<JournalCreateState> _mapExampleEventToState() async* {
    yield state.update(title: '');
  }
}
