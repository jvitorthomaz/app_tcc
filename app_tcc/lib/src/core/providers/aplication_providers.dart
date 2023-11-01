
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/restClient/rest_client.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';
import 'package:tcc_app/src/repositories/places/places_repository.dart';
import 'package:tcc_app/src/repositories/places/places_repository_impl.dart';
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

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async{
  final result = await ref.watch(userRespositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
PlacesRepository placesRepository(PlacesRepositoryRef ref) => 
  PlacesRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<PlaceModel> getAdmPlace(GetAdmPlaceRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final placeRepository = ref.watch(placesRepositoryProvider);
  final result = await placeRepository.getAdmPlace(userModel);

  return switch (result) {
    Success(value: final place) => place,
    Failure(:final exception) => throw exception,
  };
}
