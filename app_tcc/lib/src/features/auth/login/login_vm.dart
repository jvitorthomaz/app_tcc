import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/exceptions/service_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/features/auth/login/login_state.dart';
import 'package:tcc_app/src/models/users_model.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async{
    final asyncLoaderHendler = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

    switch (result) {
    case Success():
    // Buscar os dados do usuarios logados
    // Fazer analise para o tipo de login (Adm ou funcionario)

        // Invalidação dos caches para evitar o Login com o usuário errado
        ref.invalidate(getMeProvider);
        ref.invalidate(getAdmPlaceProvider);

        final userModel = await ref.read(getMeProvider.future);
        switch(userModel) {
          case AdmUserModel():
            state = state.copyWith(status: LoginStateStatus.admLogin);
            
          case EmployeeUserModel():
            state = state.copyWith(status: LoginStateStatus.employeeLogin);
        }
      break;
    case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message
        );
   }
    asyncLoaderHendler.close();
  }
}