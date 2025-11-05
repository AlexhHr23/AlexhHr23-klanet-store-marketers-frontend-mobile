
import 'package:image_picker/image_picker.dart';

abstract class CameraGalleryServices {

  Future<String?> takePhoto();
  Future<XFile?> selectPhto();
}