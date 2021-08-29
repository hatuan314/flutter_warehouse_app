import 'package:image_picker/image_picker.dart';

class ImageUseCase {

  Future<PickedFile> getImageFile(ImageSource source) async {
    return ImagePicker().getImage(source: source, maxHeight: 1080, maxWidth: 1080);
  }
}