import 'dart:developer';
import 'dart:typed_data';

import 'package:flutterwarehouseapp/common/utils/image_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/image_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/image_repository.dart';
import 'package:image_picker/image_picker.dart';

class ImageUseCase {
  final ImageRepository imageStorageRepo;

  ImageUseCase(this.imageStorageRepo);

  Future<List<ImageEntity>> uploadImageUrls(String collection,
      {List<PickedFile> imageFiles,
        String uid}) async {
    List<ImageEntity> photoList = [];
    List<Uint8List> byteDataImageList =
    await ImageUtils.getUint8ListArray(imageFiles);
    List<String> pathList = await imageStorageRepo.uploadImages(
        imageUint8ListArray: byteDataImageList,
        uid: uid,
        collection: '$collection');
    for (final String path in pathList) {
      photoList.add(ImageEntity(path: path));
    }
    return photoList;
  }

  Future<void> deleteImage(String photoPath) async {
    await imageStorageRepo.deleteImage(path: photoPath);
  }

  Future<ImageEntity> getPhotoUri(ImageEntity photo) =>
      imageStorageRepo.getImageUrl(path: photo.path);

  Future<PickedFile> openCamera() async {
    PickedFile picture;
    try {
      picture = await ImagePicker()
          .getImage(source: ImageSource.camera, imageQuality: 10);
    } catch (e) {
      log("ImageStorageUseCase - openCamera - error: {${e.toString()}");
    }
    return picture;
  }
}