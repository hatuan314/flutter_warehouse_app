import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/widgets/internet_widget/bloc/internet_bloc.dart';
import 'package:flutterwarehouseapp/src/widgets/internet_widget/bloc/internet_event.dart';
import 'package:flutterwarehouseapp/src/widgets/internet_widget/bloc/internet_state.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/no_internet_widget.dart';

class InternetWidget extends StatelessWidget {
  final Widget child;

  const InternetWidget({Key key,@required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            locator<InternetBloc>()..add(CheckInternetEvent()),
      child: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          if (state is DisconnectState) {
            return NoInternetWidget();
          }
          if (state is ConnectState) {
            return child;
          }
          return SizedBox();
        },
      ),
    );
  }
}
