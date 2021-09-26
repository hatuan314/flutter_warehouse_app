import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class ProductSuggestItemWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductSuggestItemWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product?.name,
            style: ThemeText.body1.copyWith(fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product?.distributor ?? '',
                style: ThemeText.body2.copyWith(color: AppColor.grey),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: LayoutConstants.iconSmallSize,
                    color: AppColor.grey,
                  ),
                  Text(
                    '${product?.qty ?? ''}',
                    style: ThemeText.body2.copyWith(color: AppColor.grey),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
