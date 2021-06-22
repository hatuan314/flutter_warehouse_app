import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/lottie_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';

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
          onPressed: () {
            Navigator.pushNamed(context, RouteList.distributorList);
          },
          path: LottieConstants.distributorIcon,
          title: StringConstants.distributorTxt,
        ),WarehouseDashboardItemWidget(
          path: LottieConstants.unitIcon,
          onPressed: () {
            Navigator.pushNamed(context, RouteList.unitList);
          },
          title: StringConstants.unitTxt,
        ),
      ],
    );
  }
}
