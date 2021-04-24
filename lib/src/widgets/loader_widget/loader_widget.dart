import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/utils/device_dimension_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';

import 'loader_constants.dart';

class LoadingContainer extends StatelessWidget {
  LoadingContainer({@required this.key, @required this.child, this.navigator})
      : super(key: key);

  @override
  final Key key;
  final Widget child;
  final GlobalKey<NavigatorState> navigator;

  @override
  Widget build(BuildContext context) {
    final _queryData = MediaQuery.of(context);

    return Stack(
      children: <Widget>[
        child,
        BlocBuilder<LoaderBloc, LoaderState>(
          builder: (context, state) {
            return Visibility(
                visible: state.loading,
                child: !state.isTopLoading
                    ? Container(
                        key:
                            const ValueKey(LoaderConstants.loaderBackgroundKey),
                        height: _queryData.size.height,
                        width: _queryData.size.width,
                        color: Colors.black.withOpacity(
                            LoaderConstants.loaderBackgroundOpacity),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.primaryColor),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: LoaderConstants.loaderPaddingTop),
                              child: Container(
                                alignment: Alignment.topCenter,
                                color: Colors.transparent,
                                height: DeviceDimension.getProportionalWidth(
                                    _queryData.size.width,
                                    LoaderConstants.loaderWidth),
                                width: DeviceDimension.getProportionalWidth(
                                    _queryData.size.height,
                                    LoaderConstants.loaderHeight),
                                child: const Image(
                                    key: ValueKey(
                                        LoaderConstants.loaderTopImageKey),
                                    image: AssetImage(
                                        LoaderConstants.loaderImage)),
                              ))
                        ],
                      ));
          },
        ),
      ],
    );
  }
}
