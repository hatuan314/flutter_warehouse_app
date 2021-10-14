import 'dart:typed_data';

import 'package:flutterwarehouseapp/src/domain/entities/image_entity.dart';

abstract class ImageRepository {
  Future<List<String>> uploadImages(
      {List<Uint8List> imageUint8ListArray,
        String uid,
        String collection});

  Future<ImageEntity> getImageUrl({String path});

  Future<void> deleteImage({String path});
}