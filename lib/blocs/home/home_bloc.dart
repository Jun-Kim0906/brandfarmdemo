import 'package:BrandFarm/blocs/home/bloc.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc() : super(HomeState.empty());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if(event is ExampleEvent){
      yield* _mapExampleEventToState(event);
    }
  }

  Stream<HomeState> _mapExampleEventToState(ExampleEvent event) async*{
    yield state.update();
  }
}