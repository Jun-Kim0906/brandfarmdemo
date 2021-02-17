
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ProfileUtil {

  Future<File> getAlbumImage() async {
    PickedFile picked = await ImagePicker().getImage(source: ImageSource.gallery);
    if (picked != null) {
      File imageFile = File(picked.path);
      return imageFile;
    } else {
      print('No image selected');
      return null;
    }
  }

  Future<File> getCameraImage() async {
    PickedFile picked = await ImagePicker().getImage(source: ImageSource.camera);
    if (picked != null) {
      File imageFile = File(picked.path);
      return imageFile;
    } else {
      print('No image selected');
      return null;
    }
  }
}
