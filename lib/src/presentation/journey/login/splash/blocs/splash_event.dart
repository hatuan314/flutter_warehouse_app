import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {}

class InitialSplashEvent extends SplashEvent {
  @override
  List<Object> get props => [];

}