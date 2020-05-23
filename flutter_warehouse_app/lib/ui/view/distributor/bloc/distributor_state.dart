part of "distributor_bloc.dart";

abstract class DistributorState extends Equatable {

}

class DistributorInitialState extends DistributorState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class DistributorLoadingState extends DistributorState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class DistributorSuccessState extends DistributorState {
  final List<DistributorModel> allDistributors;

  DistributorSuccessState(this.allDistributors);
  @override
  // TODO: implement props
  List<Object> get props => [this.allDistributors];

}

class DistributorFailureState extends DistributorState {
  final String error;

  DistributorFailureState(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [this.error];

  @override
  String toString() => 'DistributorFailureState - Error: {$error}';

}