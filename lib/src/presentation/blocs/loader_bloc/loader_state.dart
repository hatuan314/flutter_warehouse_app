abstract class LoaderState {
  final bool loading;
  final bool isTopLoading;
  LoaderState({this.loading, this.isTopLoading = false});
}

class Loading extends LoaderState {
  @override
  final bool isTopLoading;

  Loading({this.isTopLoading = false}) : super(loading: true);
}

class Loaded extends LoaderState {
  Loaded() : super(loading: false, isTopLoading: false);
}
