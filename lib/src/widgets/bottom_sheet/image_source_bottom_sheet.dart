import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/unit_item_widget.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
        title: ImageSourceBottomSheetConstant.choiceSourceTxt,
        bodyPadding: EdgeInsets.zero,
        isExpanded: true,
        child: Column(
          children: [
            UnitItemWidget(icon: Icon(Icons.camera_alt_outlined), name: ImageSourceBottomSheetConstant.cameraTxt),
            UnitItemWidget(icon: Icon(Icons.image), name: ImageSourceBottomSheetConstant.galleryTxt),
          ],
        ));
  }
}

class ImageSourceBottomSheetConstant {
  static const choiceSourceTxt = 'Chọn ảnh';
  static const cameraTxt = 'Máy ảnh';
  static const galleryTxt = 'Thư viện ảnh';
}