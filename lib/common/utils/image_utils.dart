import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImageUtils {

  static Future<PickedFile> getImageFile(ImageSource source) async {
    return ImagePicker().getImage(source: source, maxHeight: 1080, maxWidth: 1080);
  }

  static Future<List<Uint8List>> getUint8ListArray( List<PickedFile> fileList) async {
    List<Uint8List> uint8ListArray = List<Uint8List>();
    if (fileList != null && fileList.isNotEmpty) {
      for (final PickedFile file in fileList) {
        final Uint8List fileUint8List = await file.readAsBytes();
        uint8ListArray.add(fileUint8List);
      }
    }
    return uint8ListArray;
  }
}