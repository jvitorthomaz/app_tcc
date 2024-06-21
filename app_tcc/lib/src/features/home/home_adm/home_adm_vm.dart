import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_state.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';

part 'home_adm_vm.g.dart';


@riverpod
class HomeAdmVm extends _$HomeAdmVm{
  Future<HomeAdmState> build() async {
    
    final repository = ref.read(userRespositoryProvider);
    final PlaceModel(id: placeId) = await ref.read(getAdmPlaceProvider.future);
    final me = await ref.watch(getMeProvider.future);
    
    final employeesListResult = await repository.getEmployees(placeId);

    switch(employeesListResult) {
      case Success(value: final employeesData) :
        final employees = <UserModel>[];

        // Usuario adm tbm é colaborador?
        if(me case AdmUserModel(workDays: _?, workHours: _?)) {
          employees.add(me);
        }
        
        employees.addAll(employeesData);

        return HomeAdmState(
          status: HomeAdmStateStatus.loaded, employees: employees, 
        );

      case Failure(): 
        return HomeAdmState(
          status: HomeAdmStateStatus.loaded, employees: [],
        );
    }

  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();

    Future<void> deleteUserVm(int idUser) async {
      final asyncLoaderHandler = AsyncLoaderHandler()..start();

      final userRepository = ref.read(userRespositoryProvider);
      final deleteUserResult = await userRepository.deleteUser(idUser);


      asyncLoaderHandler.close();
    }
}

