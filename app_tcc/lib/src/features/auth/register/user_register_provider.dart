import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/services/user_register_services/user_adm_register_service.dart';
import 'package:tcc_app/src/services/user_register_services/user_adm_register_service_impl.dart';

part 'user_register_provider.g.dart';

@riverpod
UserAdmRegisterService userAdmRegisterService(UserAdmRegisterServiceRef ref) =>
    UserAdmRegisterServiceImpl(
      userRepository: ref.watch(userRespositoryProvider),
      userLoginService: ref.watch(userLoginServiceProvider),
    );