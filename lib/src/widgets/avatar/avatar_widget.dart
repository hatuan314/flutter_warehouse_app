import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/image_network_widget/image_network_widget.dart';

class AvatarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(LayoutConstants.avatarSize),
          child: Container(
              height: LayoutConstants.avatarSize,
              width: LayoutConstants.avatarSize,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]
              ),
              child: ImageNetworkWidget(uri: 'https://i.pinimg.com/originals/22/cd/77/22cd77f1623a7fe1f8436cdf40b47b99.jpg',)),
        ),
        Container(
          height: LayoutConstants.smallIconBtnSize,
          width: LayoutConstants.smallIconBtnSize,
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 5, // changes position of shadow
            ),
          ], shape: BoxShape.circle, color: AppColor.primaryColor),
          child: Icon(
            Icons.camera_alt_outlined,
            size: LayoutConstants.iconSize,
            color: AppColor.white,
          ),
        )
      ],
    );
  }
}
