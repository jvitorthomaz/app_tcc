
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/restClient/rest_client.dart';
import 'package:tcc_app/src/repositories/user/user_repository.dart';
import 'package:tcc_app/src/repositories/user/user_repository_impl.dart';
import 'package:tcc_app/src/services/user_login_service.dart';
import 'package:tcc_app/src/services/user_login_service_impl.dart';

part 'aplication_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRespository userRespository(UserRespositoryRef ref) => 
  UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) => 
  UserLoginServiceImpl(userRespository: ref.read(userRespositoryProvider));
