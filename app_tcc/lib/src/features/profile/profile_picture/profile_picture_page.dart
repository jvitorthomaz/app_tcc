

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/defaults_snackbar/show_snackbar.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';
import 'package:tcc_app/src/features/profile/profile_picture/profile_picture_vm.dart';
import 'package:tcc_app/src/features/profile/profile_picture/widgets/profile_picture_source_modal_widget.dart';
import 'package:tcc_app/src/models/image_custom_info_model.dart';
import 'package:tcc_app/src/models/users_model.dart';
import 'package:tcc_app/src/repositories/clouldStorage/clould_storage_repository.dart';

class ProfilePicturePage extends ConsumerStatefulWidget {
  const ProfilePicturePage({super.key});

  @override
  ConsumerState<ProfilePicturePage> createState() => _ProfilePicturePageState();
}

class _ProfilePicturePageState extends ConsumerState<ProfilePicturePage> {
  String? urlPhoto;
  List<ImageCustomInfoModel> listFiles = [];

  final ClouldStorageRepository _storageRepository = ClouldStorageRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  reload() {
    setState(() {
      urlPhoto = _firebaseAuth.currentUser!.photoURL;
    });

    _storageRepository.listAllFiles().then((List<ImageCustomInfoModel> listFilesInfo) {
      setState(() {
        listFiles = listFilesInfo;
      });
    });
  }

  @override
  void initState() {
    reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    final userUpdateProfilePictureVm = ref.watch(profilePictureVmProvider.notifier);

    reload() {
      setState(() {
        urlPhoto = _firebaseAuth.currentUser!.photoURL;
      });

      _storageRepository.listAllFiles().then((List<ImageCustomInfoModel> listFilesInfo) {
        setState(() {
          listFiles = listFilesInfo;
        });
      });
    }

    uploadImage() {
      ImagePicker imagePicker = ImagePicker();
      showSourceModalWidget(context: context).then((bool? value) {
        ImageSource source = ImageSource.gallery;
        if (value != null) {
          if (value) {
            source = ImageSource.gallery;
            
          } else {
            source = ImageSource.camera;
            
          }
          imagePicker.pickImage(
            source: source,
            maxHeight: 2000,
            maxWidth: 2000,
            imageQuality: 50,
          )
          .then((XFile? image) async{
              if (image != null) {
                await userUpdateProfilePictureVm.uploadUserProfilePicture(
                  userId: userModel.id, 
                  file: File(image.path), 
                  fileName: DateTime.now().toString(),
                );
                await reload();
                ref.invalidate(getMeProvider);  
                ref.invalidate(homeAdmVmProvider);
                //Navigator.of(context).pop();
                // _storageRepository
                //     .upload(file: File(image.path), fileName: DateTime.now().toString())
                //     .then((String urlDownload) {
                //   setState(() {
                //     urlPhoto = urlDownload;
                //   });
                //   reload();
                // });
              } else {
                showSnackBar(context: context, mensagem: "Nenhuma imagem selecionada.");
              }
            });
        }
      });

      // imagePicker.pickImage(
      //   source: ImageSource.gallery,
      //   maxHeight: 2000,
      //   maxWidth: 2000,
      //   imageQuality: 50,
      // )
      // .then((XFile? image) async{
      //     if (image != null) {
      //       await userUpdateProfilePictureVm.uploadUserProfilePicture(
      //         userId: userModel.id, 
      //         file: File(image.path), 
      //         fileName: DateTime.now().toString(),
      //       );
      //       await reload();
      //       ref.invalidate(getMeProvider);  
      //       ref.invalidate(homeAdmVmProvider);
      //       //Navigator.of(context).pop();
      //       // _storageRepository
      //       //     .upload(file: File(image.path), fileName: DateTime.now().toString())
      //       //     .then((String urlDownload) {
      //       //   setState(() {
      //       //     urlPhoto = urlDownload;
      //       //   });
      //       //   reload();
      //       // });
      //     } else {
      //       showSnackBar(context: context, mensagem: "Nenhuma imagem selecionada.");
      //     }
      //   });
    }


    selectImage(ImageCustomInfoModel imageInfo) async {
      await _firebaseAuth.currentUser!.updatePhotoURL(imageInfo.urlDownload);
      setState(() {
        urlPhoto = imageInfo.urlDownload;
      });
    }

    deleteImage(ImageCustomInfoModel imageInfo) {
      _storageRepository.deleteByReference(imageInfo: imageInfo).then((value) {
        if (urlPhoto == imageInfo.urlDownload) {
          urlPhoto = null;
        }
        reload();
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Foto de Perfil"),
        actions: [
          IconButton(
            onPressed: () {
              uploadImage();
            },
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: const Icon(Icons.upload, size: 30,),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     reload();
          //   },
          //   icon: const Icon(Icons.refresh),
          // ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: (urlPhoto != null) ? 
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                urlPhoto!,
                
              )
                  
            )
            : const CircleAvatar(
                radius: 64,
                child: Icon(Icons.person, size: 50,),
              ),
        ),
      ),
    );
  }

  // uploadImage() {
  //   ImagePicker imagePicker = ImagePicker();

  //   imagePicker.pickImage(
  //     source: ImageSource.gallery,
  //     maxHeight: 2000,
  //     maxWidth: 2000,
  //     imageQuality: 50,
  //   )
  //   .then((XFile? image) {
  //       if (image != null) {
  //         userUpdateProfilePictureVm.
  //         // _storageRepository
  //         //     .upload(file: File(image.path), fileName: DateTime.now().toString())
  //         //     .then((String urlDownload) {
  //         //   setState(() {
  //         //     urlPhoto = urlDownload;
  //         //   });
  //         //   reload();
  //         // });
  //       } else {
  //         showSnackBar(context: context, mensagem: "Nenhuma imagem selecionada.");
  //       }
  //     });
  // }

  // reload() {
  //   setState(() {
  //     urlPhoto = _firebaseAuth.currentUser!.photoURL;
  //   });

  //   _storageRepository.listAllFiles().then((List<ImageCustomInfoModel> listFilesInfo) {
  //     setState(() {
  //       listFiles = listFilesInfo;
  //     });
  //   });
  // }

  // selectImage(ImageCustomInfoModel imageInfo) {
  //   _firebaseAuth.currentUser!.updatePhotoURL(imageInfo.urlDownload);
  //   setState(() {
  //     urlPhoto = imageInfo.urlDownload;
  //   });
  // }

  // deleteImage(ImageCustomInfoModel imageInfo) {
  //   _storageRepository.deleteByReference(imageInfo: imageInfo).then((value) {
  //     if (urlPhoto == imageInfo.urlDownload) {
  //       urlPhoto = null;
  //     }
  //     reload();
  //   });
  // }
}
