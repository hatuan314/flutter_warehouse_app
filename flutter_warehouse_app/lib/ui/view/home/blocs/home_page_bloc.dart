import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  @override
  // TODO: implement initialState
  HomePageState get initialState => HomePageInitialState(0);

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is NavigationBottomItemOnPressEvent) {
      yield HomePageChangeNavigationBottiomItemState();
      yield HomePageInitialState(event.index);
    }


  }

}