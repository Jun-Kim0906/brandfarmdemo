import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;


Future<File> resizeImage (File originImage)async{
  if (originImage == null) {
    return null;
  }
  final path = (await getTemporaryDirectory()).path;
  int rand = Random().nextInt(10000);
  Im.Image image = Im.decodeImage(originImage.readAsBytesSync());
  Im.Image smallerImage = Im.copyResize(image,
      width: 400,
      height: 400); // choose the size here, it will maintain aspect ratio
  return File('$path/img_$rand.jpg')
    ..writeAsBytesSync(Im.encodeJpg(smallerImage, quality: 85));
}