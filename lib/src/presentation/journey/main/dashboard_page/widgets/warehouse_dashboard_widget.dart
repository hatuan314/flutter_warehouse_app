import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/lottie_constants.dart';

import 'dashboard_item_widget.dart';

class WarehouseDashboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        childAspectRatio: 2,
      ),
      children: [
        WarehouseDashboardItemWidget(
          path: LottieConstants.productIcon,
          title: 'Mặt hàng',
        ),WarehouseDashboardItemWidget(
          path: LottieConstants.categoryIcon,
          title: 'Danh mục',
        ),WarehouseDashboardItemWidget(
          path: LottieConstants.distributorIcon,
          title: 'Nhà phân phối',
        ),WarehouseDashboardItemWidget(
          path: LottieConstants.unitIcon,
          title: 'Đơn vị tính',
        ),
      ],
    );
  }
}
