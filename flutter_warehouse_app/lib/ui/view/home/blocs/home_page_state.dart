part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {}

class HomePageChangeNavigationBottiomItemState extends HomePageState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class HomePageInitialState extends HomePageState {
  final int index;

  HomePageInitialState(this.index);

  @override
  // TODO: implement props
  List<Object> get props => [this.index];
}
