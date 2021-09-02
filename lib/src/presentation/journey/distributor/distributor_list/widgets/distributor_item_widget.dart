
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/widgets/touchable_widget.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/color_utils.dart';
import 'package:flutterwarehouseapp/common/utils/name_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/distributor_list_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class DistributorItemWidget extends StatelessWidget {
  final DistributorEntity distributor;
  final int index;
  final Function onDelete;
  final Function onPressedDetail;

  const DistributorItemWidget({
    Key key,
    @required this.distributor,
    @required this.index,
    @required this.onDelete,
    @required this.onPressedDetail,
  }) : super(key: key);

  Widget _leadingWidget() {
    return Container(
      width: DistributorListConstants.avatarSize,
      height: DistributorListConstants.avatarSize,
      decoration: BoxDecoration(
        color: ColorUtils.convertColor(distributor.color),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        NameUtils.getSortName(distributor.name),
        style: ThemeText.body1.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColor.white,
        ),
      ),
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
      child: TouchableWidget(
        onPressed: onPressedDetail,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: LayoutConstants.paddingVerticalApp,
            horizontal: LayoutConstants.paddingHorizontalApp,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _leadingWidget(),
              SizedBox(width: LayoutConstants.paddingHorizontal10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      distributor?.name ?? '',
                      style: ThemeText.subtitle1,
                    ),
                    distributor.phones.isSafe
                        ? Text(
                      distributor?.phones[0],
                      style: ThemeText.caption,
                    )
                        : SizedBox(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
