import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/screen_utils_extensions.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/distributor_list_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/skeleton_widget.dart';
import 'package:shimmer/shimmer.dart';

class DistributorListSkeletonWidget extends StatelessWidget {
  Widget _itemWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
      ),
      elevation: 10,
      margin:
          EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontalApp)
              .copyWith(top: LayoutConstants.paddingVertical20),
      color: AppColor.white,
      child: SkeletonWidget(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: LayoutConstants.paddingVertical10),
          child: Row(
            children: [
              Container(
                width: DistributorListConstants.avatarSize,
                height: DistributorListConstants.avatarSize,
                margin: EdgeInsets.symmetric(
                  horizontal: LayoutConstants.paddingHorizontalApp,
                ),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: LayoutConstants.paddingHorizontalApp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: AppColor.white,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 80.0.w,
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
