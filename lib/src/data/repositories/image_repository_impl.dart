import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/image_storage_datasource.dart';
import 'package:flutterwarehouseapp/src/domain/entities/image_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageStorageDataSource imageStorageDs;

  ImageRepositoryImpl({@required this.imageStorageDs});

  @override
  Future<void> deleteImage({String path}) {
    // TODO: implement deleteImage
    throw UnimplementedError();
  }

  @override
  Future<ImageEntity> getImageUrl({String path}) => imageStorageDs.getImageUrl(path);

  @override
  Future<List<String>> uploadImages({List<Uint8List> imageUint8ListArray, String uid, String collection}) =>
      imageStorageDs.uploadImages(imageUint8ListArray: imageUint8ListArray, uid: uid, collection: collection);
}
