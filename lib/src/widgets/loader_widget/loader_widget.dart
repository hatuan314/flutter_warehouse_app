import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/lottie_constants.dart';
import 'package:flutterwarehouseapp/common/utils/device_dimension_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:lottie/lottie.dart';

import 'loader_constants.dart';

class LoadingContainer extends StatelessWidget {
  LoadingContainer({@required this.child, this.navigator})
      : super(key: const ValueKey('LoadingContainer'));

  @override
  final Widget child;
  final GlobalKey<NavigatorState> navigator;

  @override
  Widget build(BuildContext context) {
    final _queryData = MediaQuery.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        children: <Widget>[
          child,
          BlocBuilder<LoaderBloc, LoaderState>(
            builder: (context, state) {
              return Visibility(
                  visible: state.loading,
                  child: !state.isTopLoading
                      ? Container(
                          key: const ValueKey(
                              LoaderConstants.loaderBackgroundKey),
                          height: _queryData.size.height,
                          width: _queryData.size.width,
                          color: Colors.black.withOpacity(
                              LoaderConstants.loaderBackgroundOpacity),
                          child: Center(
                            child: Lottie.asset(
                              LottieConstants.loadingIcon,
                              width: LayoutConstants.loadingSize,
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
                                child: Center(
                                  child: Lottie.asset(
                                    LottieConstants.loadingIcon,
                                    width: LayoutConstants.loadingSize,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ));
            },
          ),
        ],
      ),
    );
  }
}
