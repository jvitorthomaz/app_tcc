
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/features/auth/register/register_user/user_register_provider.dart';

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

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
   final userAdmRegisterService = ref.watch(userAdmRegisterServiceProvider);//

    final userDTO = (
      name: name,
      email: email,
      password: password,
    );

    final registerResult = await userAdmRegisterService.execute(userDTO); //.asyncLoader();
    
    switch(registerResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = UserUpdatePasswordStateStatus.success;

      case Failure():
        state = UserUpdatePasswordStateStatus.error;  
        
    }

  }

}
