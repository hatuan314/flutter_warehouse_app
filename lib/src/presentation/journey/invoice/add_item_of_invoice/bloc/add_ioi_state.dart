import 'package:equatable/equatable.dart';
abstract class AddIoiState extends Equatable {}

class WaitingAddIoiState extends AddIoiState {
  final String selectUnit;

  WaitingAddIoiState({this.selectUnit});

  WaitingAddIoiState copyWith({String selectUnit}) => WaitingAddIoiState(selectUnit: selectUnit ?? this.selectUnit);

  @override
  List<Object> get props => [this.selectUnit];
}
