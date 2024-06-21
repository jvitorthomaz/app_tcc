

import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/features/profile/update_profile/profile_update_state.dart';
import 'package:tcc_app/src/repositories/user/user_repository.dart';

part 'profile_update_vm.g.dart';

@riverpod
class ProfileUpdateVm extends _$ProfileUpdateVm{

 ProfileUpdateState build() => ProfileUpdateState.initial();

  void addOrRemoveWorkdays(String weekDay) {
    final ProfileUpdateState(:workdays) = state;

    if(workdays.contains(weekDay)) {
      workdays.remove(weekDay);

    } else {
      workdays.add(weekDay);

    }

    state = state.copyWith(workdays: workdays);
  }

  void addOrRemoveWorkhours(int hour) {
    final ProfileUpdateState(:workhours) = state;

    if (workhours.contains(hour)) {
      workhours.remove(hour);
    } else {
      workhours.add(hour);
    }

    state = state.copyWith(workhours: workhours);
  }



  Future<void> update({int? userId, String? name, String? email, String? password}) async {
    final ProfileUpdateState(
      :workdays, 
      :workhours
    ) = state;

    final asyncLoadHandler = AsyncLoaderHandler()..start();
    
    final UserRespository(
      :updateUserProfile
    ) = ref.read(userRespositoryProvider);

    final Either<RepositoryException, Nil> resultUpdate;   

      final dtoRegisterEmployee = (
        userId: userId!,
        name: name!,
        email: email!,
        workDays: workdays,
        workHours: workhours
      );

    resultUpdate = await updateUserProfile(dtoRegisterEmployee);

    switch(resultUpdate) {
      case Success():
        state = state.copyWith(status:ProfileUpdateStateStatus.success);
      case Failure():
        state = state.copyWith(status:ProfileUpdateStateStatus.error);
    }

    asyncLoadHandler.close();
  }
}
