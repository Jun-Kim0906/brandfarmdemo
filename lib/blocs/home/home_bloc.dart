import 'package:BrandFarm/blocs/home/bloc.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc() : super(HomeState.empty());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if(event is NextMonthClicked){
      yield* _mapNextMonthClickedToState();
    } else if(event is PrevMonthClicked){
      yield* _mapPrevMonthClickedToState();
    } else if(event is DateClicked){
      yield* _mapDateClickedToState(event.SelectedDay);
    } else if(event is BottomNavBarClicked){
      yield* _mapBottomNavBarClickedToState(event.index);
    }
  }

  Stream<HomeState> _mapNextMonthClickedToState() async*{
    if(state.selectedMonth==12){
      yield state.update(monthState: 1, yearState: state.selectedYear+1, dayState: 1);
    }else{
      yield state.update(monthState: state.selectedMonth+1, dayState: 1);
    }
  }

  Stream<HomeState> _mapPrevMonthClickedToState() async*{
    if(state.selectedMonth==1){
      yield state.update(monthState: 12, yearState: state.selectedYear-1, dayState: 1);
    }else{
      yield state.update(monthState: state.selectedMonth-1, dayState: 1);
    }
  }

  Stream<HomeState> _mapDateClickedToState(int SelectedDay) async*{
    yield state.update(dayState: SelectedDay);
  }

  Stream<HomeState> _mapBottomNavBarClickedToState(int index) async*{
    yield state.update(currentIndex: index);
  }
}