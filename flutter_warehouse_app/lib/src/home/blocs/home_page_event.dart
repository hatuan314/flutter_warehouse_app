part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {

}

class NavigationBottomItemOnPressEvent extends HomePageEvent {
  final int index;

  NavigationBottomItemOnPressEvent(this.index);
  @override
  // TODO: implement props
  List<Object> get props => [this.index];

}