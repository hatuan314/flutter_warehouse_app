import 'package:equatable/equatable.dart';

abstract class InternetState extends Equatable {
}

class ConnectState extends InternetState {
  @override
  List<Object> get props => [];

}

class DisconnectState extends InternetState {
  @override
  List<Object> get props => [];
}