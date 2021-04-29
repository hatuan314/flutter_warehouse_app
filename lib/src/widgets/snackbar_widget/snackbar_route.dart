import 'dart:async';

import 'package:flutter/material.dart';

import 'constants.dart';
import 'snackbar_widget.dart';

class TopSnackBarRoute<T> extends OverlayRoute<T> {
  final ThemeData theme;
  Future<T> get completed => _transitionCompleter.future;
  final Completer<T> _transitionCompleter = Completer<T>();

  /// This string is a workaround until Dismissible supports a returning item
  String dismissibleKeyGen = '';
  final List<DismissDirection> dismissDirections = const [
    DismissDirection.horizontal,
    DismissDirection.up
  ];
  final TopSnackBar topSnackBar;
  final Builder _builder;
  Alignment _initialAlignment;
  Alignment _endAlignment;

  bool _wasDismissedBySwipe = false;

  T _result;

  @protected
  AnimationController get animationController => _animationController;
  AnimationController _animationController;

  Animation<Alignment> _animation;

  Timer _timer;
  TopSnackBarStatus currentStatus;

  final TopSnackBarStatusCallBack _onStatusChanged;

  bool get opaque => false;
  String dismissibleKey = '';

  Duration animationDuration = const Duration(milliseconds: 350);

  TopSnackBarRoute(
      {@required this.theme,
      @required this.topSnackBar,
      RouteSettings settings})
      : _builder = Builder(builder: (BuildContext innerContext) {
          return Container(
            child: topSnackBar,
          );
        }),
        _onStatusChanged = topSnackBar.onStatusChanged,
        super(settings: settings) {
    _configureAlignment();
  }

  void _configureAlignment() {
    _initialAlignment = const Alignment(-1.0, -2.0);
    _endAlignment = const Alignment(-1.0, -1.0);
  }

  void _handleStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        currentStatus = TopSnackBarStatus.showing;
        _onStatusChanged(currentStatus);
        if (overlayEntries.isNotEmpty) {
          overlayEntries.first.opaque = opaque;
        }
        break;
      case AnimationStatus.forward:
        currentStatus = TopSnackBarStatus.isAppearing;
        _onStatusChanged(currentStatus);
        break;
      case AnimationStatus.reverse:
        currentStatus = TopSnackBarStatus.isHiding;
        _onStatusChanged(currentStatus);
        if (overlayEntries.isNotEmpty) {
          overlayEntries.first.opaque = false;
        }
        break;
      case AnimationStatus.dismissed:
        assert(
            !overlayEntries.first.opaque,
            'We might still be the current '
            'route if a subclass is controlling the transition and hits the '
            'dismissed status. For example, the iOS back gesture drives this '
            'animation to the dismissed status before poping the navigator');
        currentStatus = TopSnackBarStatus.dismissed;
        _onStatusChanged(currentStatus);
        if (!isCurrent) {
          navigator.finalizeRoute(this);
          assert(overlayEntries.isEmpty, '');
        }
        break;
    }
    changedInternalState();
  }

  @override
  bool get finishedWhenPopped =>
      _animationController.status == AnimationStatus.dismissed;

  AnimationController createAnimationController() {
    assert(animationDuration != null && animationDuration >= Duration.zero,
        'Can not reuse a $runtimeType if duration = 0');
    return AnimationController(
      duration: animationDuration,
      debugLabel: debugLabel,
      vsync: navigator,
    );
  }

  Animation<Alignment> createAnimation() {
    assert(animationController != null, 'Can not reuse a $runtimeType');
    return AlignmentTween(begin: _initialAlignment, end: _endAlignment).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCirc,
        reverseCurve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  void install() {
    _animationController = createAnimationController();
    assert(_animationController != null,
        '$runtimeType.createAnimationController() returned null.');
    _animation = createAnimation();
    assert(_animation != null, '$runtimeType.createAnimation() returned null.');
    super.install();
  }

  @override
  TickerFuture didPush() {
    assert(
        _animationController != null,
        '$runtimeType.didPush called before calling install() or '
        'after calling dispose().');
    _animation.addStatusListener(_handleStatusChanged);
    _configureTimer();
    super.didPush();
    return _animationController.forward();
  }

  @override
  bool didPop(T result) {
    assert(
        _animationController != null,
        '$runtimeType.didPop called before calling install() '
        'or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');

    _result = result;
    _cancelTimer();
    if (_wasDismissedBySwipe) {
      Timer(const Duration(milliseconds: 200), () {
        _animationController.reset();
      });

      _wasDismissedBySwipe = false;
    } else {
      _animationController.reverse();
    }

    return super.didPop(result);
  }

  void _configureTimer() {
    if (topSnackBar.duration != null) {
      if (_timer != null && _timer.isActive) {
        _timer.cancel();
      }
      _timer = Timer(const Duration(seconds: 4), () {
        if (isCurrent) {
          navigator.pop();
        } else if (isActive) {
          navigator.removeRoute(this);
        }
      });
    } else {
      if (_timer != null) {
        _timer.cancel();
      }
    }
  }

  void _cancelTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }

  void _onDismissed(DismissDirection direction) {
    dismissibleKeyGen += 'key';
    _cancelTimer();
    _wasDismissedBySwipe = true;
    if (isCurrent) {
      navigator.pop();
    } else {
      navigator?.removeRoute(this);
    }
  }

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    final overlays = <OverlayEntry>[];

    final alignTransition = AlignTransition(
        alignment: _animation,
        child: _getDismissibleWidget(
          _builder,
        ));

    overlays.add(OverlayEntry(
        builder: (BuildContext context) {
          final Widget annotatedChild = Semantics(
            focused: false,
            container: true,
            explicitChildNodes: true,
            child: alignTransition,
          );
          return theme != null
              ? Theme(
                  data: theme,
                  child: annotatedChild,
                )
              : annotatedChild;
        },
        maintainState: false,
        opaque: opaque));

    return overlays;
  }

  Widget _getDismissibleWidget(
    Widget child,
  ) {
    Widget childWidget = child;
    for (final direction in dismissDirections) {
      childWidget = Dismissible(
        key: ValueKey(dismissibleKeyGen),
        resizeDuration: null,
        direction: direction,
        confirmDismiss: (_) {
          if (currentStatus == TopSnackBarStatus.isAppearing ||
              currentStatus == TopSnackBarStatus.isHiding) {
            return Future.value(false);
          }
          return Future.value(true);
        },
        onDismissed: _onDismissed,
        child: childWidget,
      );
    }
    return childWidget;
  }

  /// short description of this route useful for debugging
  String get debugLabel => '$runtimeType';

  @override
  String toString() {
    return '$runtimeType(animation: $_animationController)';
  }

  @override
  void dispose() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot dispose a $runtimeType twice.');
    _animationController?.dispose();
    _transitionCompleter.complete(_result);
    super.dispose();
  }
}

TopSnackBarRoute showSnackBar<U>(
    {@required BuildContext context, @required TopSnackBar topSnackBar}) {
  assert(topSnackBar != null, 'showSnackBar==topsnackBar is null');

  return TopSnackBarRoute<U>(
      topSnackBar: topSnackBar,
      theme: Theme.of(context),
      settings: const RouteSettings(name: topSnackBarRouteName));
}
