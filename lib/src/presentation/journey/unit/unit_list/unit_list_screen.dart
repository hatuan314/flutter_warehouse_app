import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_state.dart';

class UnitListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitListBloc, UnitListState>(
      builder: (context, snapshot) {
        return Scaffold(
          body: Center(child: Text('Unit'),),
        );
      }
    );
  }

}