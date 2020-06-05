part of 'distributor_bloc.dart';

abstract class DistributorEvent extends Equatable {}

class BtnAddDistributorOnPressEvent extends DistributorEvent {
  final String name;
  final String address;
  final String phoneOne;
  final String phoneTwo;

  BtnAddDistributorOnPressEvent(this.name, this.address, this.phoneOne,
      {this.phoneTwo});

  @override
  // TODO: implement props
  List<Object> get props =>
      [this.name, this.address, this.phoneOne, this.phoneTwo];
}

class ShowAllDistributorsEvent extends DistributorEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class BtnFilterDistributorsOptionOnPressEvent extends DistributorEvent {
  final int actionIndex;

  BtnFilterDistributorsOptionOnPressEvent(this.actionIndex);

  @override
  // TODO: implement props
  List<Object> get props => [this.actionIndex];

}

class BtnOpenSearchDistributorOnPressEvent extends DistributorEvent {
  final bool isOpenSearchForm;

  BtnOpenSearchDistributorOnPressEvent(this.isOpenSearchForm);

  @override
  // TODO: implement props
  List<Object> get props => [this.isOpenSearchForm];

}

class TypeKeyboardSearchDistributorEvent extends DistributorEvent {
  final String keyword;

  TypeKeyboardSearchDistributorEvent(this.keyword);
  @override
  // TODO: implement props
  List<Object> get props => [this.keyword];

}
