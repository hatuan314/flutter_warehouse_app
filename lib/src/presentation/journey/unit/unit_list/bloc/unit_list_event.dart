import 'package:equatable/equatable.dart';

abstract class UnitListEvent extends Equatable {

}

class InitialUnitListEvent extends UnitListEvent {
  @override
  List<Object> get props => [];

}