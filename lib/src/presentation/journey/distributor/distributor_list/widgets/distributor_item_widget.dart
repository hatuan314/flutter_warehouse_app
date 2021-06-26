import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/color_utils.dart';
import 'package:flutterwarehouseapp/common/utils/name_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/expansion_tile_widget.dart';

class DistributorItemWidget extends StatelessWidget {
  final DistributorEntity distributor;

  const DistributorItemWidget({Key key, @required this.distributor})
      : super(key: key);

  Widget _iconButton(
      {IconData icon, Function onPressed, Color backgroundColor}) {
    return Container(
      width: LayoutConstants.smallIconCircleBtnSize,
      height: LayoutConstants.smallIconCircleBtnSize,
      child: new FloatingActionButton(
        elevation: 0.0,
        child: Icon(
          icon,
          color: Colors.white,
          size: LayoutConstants.iconSmallSize,
        ),
        backgroundColor: backgroundColor,
        onPressed: onPressed,
      ),
    );
  }

  Widget _dashboardWidget() {
    return Padding(
      padding: EdgeInsets.only(top: LayoutConstants.paddingVertical10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _iconButton(
            icon: Icons.mail,
            onPressed: () {},
            backgroundColor: AppColor.deepPurpleAccent,
          ),
          SizedBox(
            width: LayoutConstants.paddingHorizontal18,
          ),
          _iconButton(
            icon: Icons.chat_bubble,
            onPressed: () {},
            backgroundColor: AppColor.blue,
          ),
          SizedBox(
            width: LayoutConstants.paddingHorizontal18,
          ),
          _iconButton(
            icon: Icons.phone,
            onPressed: () {},
            backgroundColor: AppColor.green,
          ),
          // FloatingActionButton(onPressed: (){},
          // child: Icon(Icons.phone, size: LayoutConstants.iconSmallSize,),),
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: LayoutConstants.paddingHorizontalApp,
          ),
          padding: EdgeInsets.all(LayoutConstants.paddingVertical15),
          decoration: BoxDecoration(
            color: ColorUtils.convertColor(distributor.color),
            shape: BoxShape.circle,
          ),
          child: Text(
            NameUtils.getSortName(distributor.name),
            style: ThemeText.body1.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              distributor.name,
              style: ThemeText.subtitle1,
            ),
            SizedBox(height: 3,),
            distributor.phones.isSafe
                ? Text(
                    distributor?.phones[0],
                    style: ThemeText.caption,
                  )
                : SizedBox(),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
      ),
      elevation: 10,
      margin:
          EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontalApp)
              .copyWith(top: LayoutConstants.paddingVertical20),
      color: AppColor.white,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: LayoutConstants.paddingVertical10),
        child: ExpansionTileWidget(
          title: _titleWidget(),
          tilePadding: EdgeInsets.zero,
          children: [_dashboardWidget()],
        ),
      ),
    );
  }
}
