
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';

part 'user_update_password_vm.g.dart';

enum UserUpdatePasswordStateStatus{
  initial, 
  success, 
  error
}

@riverpod
class UserUpdatePasswordVm extends _$UserUpdatePasswordVm{
  
  @override
  UserUpdatePasswordStateStatus build() => UserUpdatePasswordStateStatus.initial;

  Future<void> updateLoggedUserPassword({
    required String password,
  }) async {
    final userUpdatePassword = ref.watch(userRespositoryProvider);//
    final userModel = await ref.watch(getMeProvider.future);

    final userDTO = (
      userId: userModel.id,
      password: password,
    );

    final updatePasswordResult = await userUpdatePassword.updateLoggedUserPassword(userDTO); //.asyncLoader();
    
    switch(updatePasswordResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = UserUpdatePasswordStateStatus.success;

      case Failure():
        state = UserUpdatePasswordStateStatus.error;  
        
    }

  }

}
