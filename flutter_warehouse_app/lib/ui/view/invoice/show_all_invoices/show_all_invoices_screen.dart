import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterwarehouseapp/ui/view/invoice/show_all_invoices/bloc/show_all_invoices_bloc.dart';

import 'package:flutterwarehouseapp/ui/view/invoice/show_all_invoices/widgets/widgets.dart';
import 'package:flutterwarehouseapp/ui/widgets/base_app_bar_widget.dart';
import 'package:flutterwarehouseapp/ui/widgets/loading/loading_view.dart';

class ShowAllInvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ShowAllInvoicesBloc, ShowAllInvoicesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.indigo[800],
          appBar: BaseAppBarWidget(
            title: 'Hóa đơn',
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: Colors.white, size: 24),
              ),
              IconButton(
                icon: Icon(Icons.sort, color: Colors.white, size: 24),
              ),
              IconButton(
                onPressed: () => Navigator.pushNamed(context, '/create-invoice'),
                icon: Icon(Icons.add, color: Colors.white, size: 24),
              )
            ],
          ),
          body: _buildBody(state),
        );
      }
    );
  }

  Widget _buildBody(ShowAllInvoicesState state) {
    if (state is ShowAllInvoicesFailureState)
      return LoadingView();
    else if (state is ShowAllInvoicesSuccessState)
      return _buildContent(state);
    else
      return _failureWidget();
  }

  Widget _failureWidget() {
    return Center(
      child: Text('Không có dữ liệu', style: TextStyle(
        fontSize: ScreenUtil().setSp(18),
        color: Colors.white,
        fontWeight: FontWeight.w600
      ),),
    );
  }

  Widget _buildContent(ShowAllInvoicesSuccessState state) {
    if (state.allInvoices.length == 0) {
      return _failureWidget();
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) => InvoiceListItemWidget());
  }
}
