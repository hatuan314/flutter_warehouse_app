import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/invoice_page/bloc/invoice_page_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/invoice_page/bloc/invoice_page_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/invoice_page/widgets/invoice_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';

import 'invoice_tab_constants.dart';

class InvoiceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoicePageBloc, InvoicePageState>(
      builder: (context, state) {
        return DefaultTabController(
          length: InvoiceTabConstants.totalTab,
          child: ScaffoldWidget(
            backgroundColor: AppColor.paleGrey,
            isLeading: false,
            title: StringConstants.invoiceTitle,
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: AppColor.white,
                  ),
                  onPressed: () {
                    locator<SnackbarBloc>().add(ShowSnackbar(title: 'Developing', type: SnackBarType.warning));
                  })
            ],
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: LayoutConstants.paddingVertical10),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteList.createInvoice);
                },
                child: Icon(
                  Icons.add,
                  size: LayoutConstants.smallIconBtnSize,
                ),
                backgroundColor: AppColor.primaryColor,
              ),
            ),
            tabBar: TabBar(
                labelPadding: EdgeInsets.symmetric(vertical: LayoutConstants.paddingVertical10),
                indicatorColor: AppColor.white,
                tabs: [
                  Text(
                    'Bán hàng',
                    style: ThemeText.body2.copyWith(color: AppColor.white),
                  ),
                  Text(
                    'Nhập hàng',
                    style: ThemeText.body2.copyWith(color: AppColor.white),
                  ),
                ]),
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(children: [
                    InvoiceWidget(
                      billList: state?.exportBillList ?? [],
                      billType: BillEnum.Export,
                      onPressedBill: (bill) => _onPressedBill(context, bill),
                    ),
                    InvoiceWidget(
                      billList: state?.importBillList ?? [],
                      billType: BillEnum.Import,
                      onPressedBill: (bill) => _onPressedBill(context, bill),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void _onPressedBill(BuildContext context, BillEntity bill) {}
}
