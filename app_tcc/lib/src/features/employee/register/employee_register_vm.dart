import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/constants/globalConst.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/features/employee/register/employee_register_state.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/repositories/user/user_repository.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm{

  EmployeeRegisterState build() => EmployeeRegisterState.initial();


  void setRegisterADM(bool isRegisterAdm) {
    //    GlobalConst.clinicAlreadyHasADM = true;
    state = state.copyWith(registerAdm: isRegisterAdm);

  }

  void addOrRemoveWorkdays(String weekDay) {
    final EmployeeRegisterState(:workdays) = state;

    if(workdays.contains(weekDay)) {
      workdays.remove(weekDay);

    } else {
      workdays.add(weekDay);

    }

    state = state.copyWith(workdays: workdays);
  }

  void addOrRemoveWorkhours(int hour) {
    final EmployeeRegisterState(:workhours) = state;

    if (workhours.contains(hour)) {
      workhours.remove(hour);
    } else {
      workhours.add(hour);
    }

    state = state.copyWith(workhours: workhours);
  }

  Future<void> register({String? name, String? email, String? password}) async {
    final EmployeeRegisterState(:registerAdm, :workdays, :workhours) = state;

    final asyncLoadHandler = AsyncLoaderHandler()..start();

    final UserRespository(
      :registerAdmAsEmployee, :registerNewEmployee
    ) = ref.read(userRespositoryProvider);

    final Either<RepositoryException, Nil> resultRegister;   

    if(registerAdm) {
      final dtoRegisterAdm = (
        workDays: workdays,
        workHours: workhours
      );
      resultRegister = await registerAdmAsEmployee(dtoRegisterAdm);

    } else {
      final PlaceModel(:id) = await ref.watch(getAdmPlaceProvider.future);

      final dtoRegisterEmployee = (
        placeId: id,
        name: name!,
        email: email!,
        //password: password!,//
        workDays: workdays,
        workHours: workhours
      );

      resultRegister = await registerNewEmployee(dtoRegisterEmployee);
    }

    switch(resultRegister) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStateStatus.error);
    }

    asyncLoadHandler.close();
  }
}
