import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/invoice_page/widgets/invoice_list_skeleton_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/animation_widget/animation_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

import 'invoice_element_widget.dart';

class InvoiceWidget extends StatelessWidget {
  final bool isShowSkeleton;
  final List<BillEntity> billList;
  final Function(int, BillEntity) onPressedBill;
  final BillEnum billType;

  const InvoiceWidget({Key key, this.isShowSkeleton, this.billList, this.onPressedBill, this.billType})
      : super(key: key);

  SliverToBoxAdapter _filterWidget() {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          padding: EdgeInsets.symmetric(
            horizontal: LayoutConstants.paddingHorizontalApp,
            vertical: LayoutConstants.paddingVerticalApp,
          ),
          icon: Icon(Icons.filter_list),
          onPressed: () => _onPressedFilter(),
        ),
      ),
    );
  }

  SliverList _invoiceListWidget() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 375),
        child: AnimationWidget(
          index: index,
          child: InvoiceElementWidget(
            bill: billList[index],
            onPressed: () => onPressedBill(index, billList[index]),
            billType: billType,
          ),
        ),
      );
    }, childCount: billList.length));
  }

  @override
  Widget build(BuildContext context) {
    if (isShowSkeleton) {
      return InvoiceListSkeletonWidget();
    }
    if (ValidatorUtils.isNullEmptyList(billList)) {
      return EmptyWidget();
    }
    return CustomScrollView(
      slivers: [
        _filterWidget(),
        _invoiceListWidget(),
      ],
    );
  }

  _onPressedFilter() {
    locator<SnackbarBloc>().add(ShowSnackbar(
      title: StringConstants.developmentTxt,
      type: SnackBarType.warning,
    ));
  }
}
