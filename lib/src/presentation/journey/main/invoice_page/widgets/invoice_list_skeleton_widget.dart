import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/screen_utils_extensions.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/skeleton_widget.dart';

class InvoiceListSkeletonWidget extends StatelessWidget {
  Widget _itemWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: LayoutConstants.paddingHorizontalApp,
        vertical: LayoutConstants.paddingVerticalApp / 2,
      ),
      elevation: 5,
      color: AppColor.white,
      child: SkeletonWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: LayoutConstants.paddingVerticalApp,
            horizontal: LayoutConstants.paddingHorizontalApp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80.0.w,
                height: 8.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: AppColor.white,
                ),
              ),
              SizedBox(
                height: LayoutConstants.paddingVertical5,
              ),
              Container(
                width: 60.0.w,
                height: 8.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: AppColor.white,
                ),
              ),
              SizedBox(
                height: LayoutConstants.paddingVertical10,
              ),
              Container(
                width: 200.w,
                height: 8.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: AppColor.white,
                ),
              ),
              SizedBox(
                height: LayoutConstants.paddingVertical5,
              ),
              Container(
                width: 100.w,
                height: 8.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: AppColor.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _itemWidget();
        });
  }
}
