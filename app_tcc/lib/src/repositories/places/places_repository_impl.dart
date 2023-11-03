
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/core/restClient/rest_client.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';
import 'package:tcc_app/src/repositories/places/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository{
  final RestClient restClient;

  PlacesRepositoryImpl({
    required this.restClient
  });
  
  @override
  Future<Either<RepositoryException, PlaceModel>> getAdmPlace(UserModel userModel) async{
    switch (userModel) {

      case AdmUserModel():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/place',
          queryParameters: {
            'user_id': '#userAuthRef'
          },
        );
        return Success(PlaceModel.fromMap(data));

      case EmployeeUserModel():
        final Response(:data) = await restClient.auth.get('/place/${userModel.placeId}');
        return Success(PlaceModel.fromMap(data));

    }
  }

  @override
  Future<Either<RepositoryException, Nil>> savePlace(
    ({String email, String name, List<String> openingDays, List<int> openingHours}) data
  ) async{
    try {
      await restClient.auth.post('/place', data: {
        'user_id': '#userAuthRef',
        'name': data.name,
        'email': data.email,
        'opening_days': data.openingDays,
        'opening_hours': data.openingHours,
      });

      return Success(nil);

    } on DioException catch (e, s) {
      log('Erro ao registrar o estabelecimento', error: e, stackTrace: s);

      return Failure(
        RepositoryException(
          message: 'Erro ao registrar o estabelecimento'
        )
      );
    }
  }
}
