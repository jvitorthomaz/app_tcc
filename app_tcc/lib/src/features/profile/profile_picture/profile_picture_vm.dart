
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';

part 'profile_picture_vm.g.dart';

enum ProfilePictureStateStatus{
  initial, 
  success, 
  error
}

@riverpod
class ProfilePictureVm extends _$ProfilePictureVm{
  
  @override
  ProfilePictureStateStatus build() => ProfilePictureStateStatus.initial;

  Future<void> uploadUserProfilePicture({
    required int userId,
    required File file,
    required String fileName,
  }) async {
    final userUploadProfilePicture = ref.watch(userRespositoryProvider);//


    final userUploadProfilePictureResult = await userUploadProfilePicture.uploadUserProfilePicture(
      fileName: fileName, 
      file: file, 
      userId: userId
    ); //.asyncLoader();
    
    switch(userUploadProfilePictureResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = ProfilePictureStateStatus.success;

      case Failure():
        state = ProfilePictureStateStatus.error;  
        
    }

  }

}