import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';

import 'constants.dart';
import 'snackbar_route.dart';

typedef TopSnackBarStatusCallBack = void Function(TopSnackBarStatus status);

const String topSnackBarRouteName = '/topSnackBarRoute';

// ignore: must_be_immutable
class TopSnackBar<T extends Object> extends StatefulWidget {
  final BuildContext context;
  final String title;
  final SnackBarType type;
  TopSnackBarStatusCallBack onStatusChanged;

  TopSnackBar(
      {Key key, this.context, this.title, this.type = SnackBarType.error})
      : super(key: key) {
    onStatusChanged = onStatusChanged ?? (status) {};
  }

  int duration = 4;

  TopSnackBarRoute<T> _topSnackBarRoute;

  Future<T> show(BuildContext context) async {
    _topSnackBarRoute = showSnackBar<T>(context: context, topSnackBar: this);

    return Navigator.of(context, rootNavigator: false).push(_topSnackBarRoute);
  }

  Future<T> showWithNavigator(
      NavigatorState navigator, BuildContext context) async {
    _topSnackBarRoute = showSnackBar<T>(context: context, topSnackBar: this);
    return navigator.push(_topSnackBarRoute);
  }

  Future<T> dismiss([T result]) async {
    if (_topSnackBarRoute == null) {
      return null;
    }

    return null;
  }

  /// Checks if the top snack bar is visible
  bool isShowing() =>
      _topSnackBarRoute?.currentStatus == TopSnackBarStatus.showing;

  /// Checks if the top snack bar is dismissed
  bool isDismissed() =>
      _topSnackBarRoute?.currentStatus == TopSnackBarStatus.dismissed;

  @override
  State createState() {
    return _TopSnackBarState<T>();
  }
}

class _TopSnackBarState<K extends Object> extends State<TopSnackBar>
    with TickerProviderStateMixin {
  FocusScopeNode _focusScopeNode;
  FocusAttachment _focusAttachment;

  TopSnackBarStatus currentStatus;

  GlobalKey backgroundBoxKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _focusScopeNode = FocusScopeNode();
    _focusAttachment = _focusScopeNode.attach(context);
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    _focusAttachment.detach();
    super.dispose();
  }

  Widget _buildIcon() {
    if (widget.type == SnackBarType.success) {
      return Container(
        key: const Key('success_container_icon_key'),
        child: Icon(
          Icons.check_circle_rounded,
          size: 32,
          color: AppColor.green,
        ),
      );
    } else {
      return Container(
        key: const Key('close_container_icon_key'),
        child: Icon(
          Icons.cancel,
          size: 32,
          color: AppColor.errorColor,
        ),
      );
    }
  }

  Widget _buildTitleText() {
    return Text(
      widget.title ?? '',
      softWrap: true,
      key: const ValueKey('snackbar_title_key'),
      style: Theme.of(context).snackBarTheme.contentTextStyle,
    );
  }

  List<Widget> _buildRowLayout() {
    return <Widget>[
      ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 41.0),
        child: _buildIcon(),
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0),
          child: _buildTitleText(),
        ),
      ),
    ];
  }

  BoxDecoration boxDecoration = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(25.0),
    boxShadow: [
      BoxShadow(
        color: AppColor.black25,
        blurRadius: 10.0,
        offset: const Offset(0.5, 0.5),
      )
    ],
  );

  Widget _buildSnackBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      key: backgroundBoxKey,
      decoration: boxDecoration,
      child: Row(
        children: _buildRowLayout(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 64.0),
      child: Material(type: MaterialType.transparency, child: _buildSnackBar()),
    );
  }
}
