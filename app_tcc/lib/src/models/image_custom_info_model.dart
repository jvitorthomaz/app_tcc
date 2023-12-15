
import 'package:firebase_storage/firebase_storage.dart';

class ImageCustomInfoModel {
  String urlDownload;
  String name;
  String size;
  Reference ref;

  ImageCustomInfoModel({
    required this.urlDownload,
    required this.name,
    required this.size,
    required this.ref,
  });
}