import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/touchable_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/unit_item_widget.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  final Function onPressedGallery;
  final Function onPressedCamera;

  const ImageSourceBottomSheet({
    Key key,
    this.onPressedGallery,
    this.onPressedCamera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
        title: ImageSourceBottomSheetConstant.choiceSourceTxt,
        bodyPadding: EdgeInsets.zero,
        isExpanded: true,
        child: Column(
          children: [
            TouchableWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                  onPressedCamera();
                },
                child: UnitItemWidget(
                    icon: Icon(Icons.camera_alt_outlined), name: ImageSourceBottomSheetConstant.cameraTxt)),
            TouchableWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                  onPressedGallery();
                },
                child: UnitItemWidget(icon: Icon(Icons.image), name: ImageSourceBottomSheetConstant.galleryTxt)),
          ],
        ));
  }
}

class ImageSourceBottomSheetConstant {
  static const choiceSourceTxt = 'Chọn ảnh';
  static const cameraTxt = 'Máy ảnh';
  static const galleryTxt = 'Thư viện ảnh';
}
