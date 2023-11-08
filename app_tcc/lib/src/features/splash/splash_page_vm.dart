import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/src/core/constants/local_storage_keys.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/models/users_model.dart';

part 'splash_page_vm.g.dart';

enum SplashPageState{
  initial,
  login,
  loggedAdm,
  loggedEmployee,
  error
}

@riverpod
class SplashPageVm extends _$SplashPageVm {
  @override
  Future<SplashPageState> build() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey(LocalStorageKeys.accessToken)) {
      ref.invalidate(getMeProvider);
      ref.invalidate(getAdmPlaceProvider);

      try {
        final userModel = await ref.watch(getMeProvider.future);

        return switch (userModel) {
          AdmUserModel() => SplashPageState.loggedAdm,
          EmployeeUserModel() => SplashPageState.loggedEmployee,
        };

      } catch (e) {
        return SplashPageState.login;
        
      }
    }
    
    return SplashPageState.login;
  }
}
