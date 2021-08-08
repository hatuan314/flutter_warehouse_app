import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/dashboard_page/widgets/option_dashboard_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/dashboard_page/widgets/user_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/dashboard_page/widgets/warehouse_dashboard_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.transparent,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: LayoutConstants.paddingHorizontal15),
          child: Column(
            children: [
              UserWidget(),
              SizedBox(height: 8,),
              WarehouseDashboardWidget(),
              SizedBox(height: 8,),
              OptionDashboardWidget()
            ],
          ),
        ),
      ),
    );
  }
}
