import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';

abstract interface class PlacesRepository {

  Future<Either<RepositoryException, PlaceModel>> getAdmPlace(UserModel userModel);

  Future<Either<RepositoryException, Nil>> savePlace(
    ({
      String name, 
      String email,
      List<String> openingDays,
      List<int> openingHours,
    }) 
    data
  );

}
