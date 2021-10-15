import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as fireStorage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/src/domain/entities/image_entity.dart';

class ImageStorageDataSource {
  Future<List<String>> uploadImages(
      {List<Uint8List> imageUint8ListArray,
        String uid,
        String collection}) async {
    List<String> pathList = [];
    try {
      for (Uint8List item in imageUint8ListArray) {
        final int timer = DateTime.now().millisecondsSinceEpoch;
        final String path = 'images/${DefaultConfig
            .storagePath}/$uid/$collection/$timer';
        fireStorage.Reference ref =
        fireStorage.FirebaseStorage.instance.ref(path);
        await ref.putData(item).whenComplete(() {
          pathList.add(path);
        });
      }
    } on Exception catch (e) {
      throw FirebaseException(
          plugin: 'CPWare',
          message:
          'ImageStorageDataSource - uploadImages - error: ${e.toString()}');
    }
    return pathList;
  }

  Future<ImageEntity> getImageUrl(String path) async {
    final fireStorage.Reference ref =
    FirebaseStorage.instance.ref().child(path);
    String uri = '';
    try {
      uri = await ref.getDownloadURL();
      return ImageEntity(path: path, uri: uri);
    } on Exception catch (e) {
      FirebaseException(
          plugin: 'CPWare',
          message:
          'ImageStorageDataSource - getImageUrl - error: ${e.toString()}');
      return null;
    }

  }

  Future<void> deleteImage(String path) async {
    final fireStorage.Reference ref =
    FirebaseStorage.instance.ref().child(path);

    try {
      await ref.delete();
    } on Exception catch (e) {
      throw FirebaseException(
          plugin: 'CPWare',
          message:
          'ImageStorageDataSource - deleteImage - error: ${e.toString()}');
    }
  }
}