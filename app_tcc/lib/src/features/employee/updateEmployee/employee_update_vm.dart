

import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/features/employee/updateEmployee/employee_update_state.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/repositories/user/user_repository.dart';

part 'employee_update_vm.g.dart';

@riverpod
class EmployeeUpdateVm extends _$EmployeeUpdateVm{

 EmployeeUpdateState build() => EmployeeUpdateState.initial();//.copyWith();



  void setUpdateADM(bool isUpdateAdm) {
    state = state.copyWith(updateAdm: isUpdateAdm);
  }

  void addOrRemoveWorkdays(String weekDay) {
    final EmployeeUpdateState(:workdays) = state;

    if(workdays.contains(weekDay)) {
      workdays.remove(weekDay);

    } else {
      workdays.add(weekDay);

    }

    state = state.copyWith(workdays: workdays);
  }

  void addOrRemoveWorkhours(int hour) {
    final EmployeeUpdateState(:workhours) = state;

    if (workhours.contains(hour)) {
      workhours.remove(hour);
    } else {
      workhours.add(hour);
    }

    state = state.copyWith(workhours: workhours);
  }

  Future<void> update({int? employeeId, String? name, String? email, String? password}) async {
    final EmployeeUpdateState(:updateAdm, :workdays, :workhours) = state;

    final asyncLoadHandler = AsyncLoaderHandler()..start();

    final UserRespository(
      //:registerAdmAsEmployee, 
      :updateEmployee
    ) = ref.read(userRespositoryProvider);

    final Either<RepositoryException, Nil> resultUpdate;   

    // if(updateAdm) {
    //   final dtoRegisterAdm = (
    //     workDays: workdays,
    //     workHours: workhours
    //   );
    //   resultRegister = await registerAdmAsEmployee(dtoRegisterAdm);

    // } else {

      //final PlaceModel(:id) = await ref.watch(getAdmPlaceProvider.future);

      final dtoRegisterEmployee = (
        //placeId: id,
        // name: name!,
        // email: email!,
        //password: password!,//
        employeeId: employeeId!,
        workDays: workdays,
        workHours: workhours
      );

      resultUpdate = await updateEmployee(dtoRegisterEmployee);

    //}

    switch(resultUpdate) {
      case Success():
        state = state.copyWith(status:EmployeeUpdateStateStatus.success);
      case Failure():
        state = state.copyWith(status:EmployeeUpdateStateStatus.error);
    }

    asyncLoadHandler.close();
  }
}