import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tcc_app/src/core/restClient/rest_client.dart';
import 'package:tcc_app/src/models/image_custom_info_model.dart';
import 'package:tcc_app/src/repositories/user/user_repository_impl.dart';

class ClouldStorageRepository {
  String pathService = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> upload(
    {required File file, required String fileName, required int userId,}
  ) async {
    await _firebaseStorage.ref("$pathService/$fileName.png").putFile(file);

    String url = await _firebaseStorage
        .ref("$pathService/$fileName.png")
        .getDownloadURL();

    await _firebaseAuth.currentUser!.updatePhotoURL(url);

    final firebaseUUID = await _firebaseAuth.currentUser!.uid;



    return url;
  }

  Future<String> getDownloadUrlByFileName({required String fileName}) async {
    return await _firebaseStorage
        .ref("$pathService/$fileName.png")
        .getDownloadURL();
  }

  Future<List<ImageCustomInfoModel>> listAllFiles() async {
    ListResult result = await _firebaseStorage.ref(pathService).listAll();
    List<Reference> listReferences = result.items;

    List<ImageCustomInfoModel> listFiles = [];

    for (Reference reference in listReferences) {
      String urlDownload = await reference.getDownloadURL();
      String name = reference.name;

      FullMetadata metadados = await reference.getMetadata();
      int? size = metadados.size;

      String sizeString = "Sem informação de tamanho.";

      if (size != null) {
        sizeString = "${size / 1000} Kb";
      }

      listFiles.add(
        ImageCustomInfoModel(
          urlDownload: urlDownload,
          name: name,
          size: sizeString,
          ref: reference
        )
      );
    }

    return listFiles;
  }

  Future<void> deleteByReference({required ImageCustomInfoModel imageInfo}) async {
    if (_firebaseAuth.currentUser!.photoURL != null) {
      if (_firebaseAuth.currentUser!.photoURL! == imageInfo.urlDownload) {
        await _firebaseAuth.currentUser!.updatePhotoURL(null);
      }
    }
    return await imageInfo.ref.delete();
  }
}
