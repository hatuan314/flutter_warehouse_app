abstract class LoaderEvent {}

class StartLoading extends LoaderEvent {
  final bool isTopLoading;
  StartLoading({this.isTopLoading = false});
}

class FinishLoading extends LoaderEvent {
  FinishLoading();
}
