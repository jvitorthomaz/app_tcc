import 'package:tcc_app/src/models/users_model.dart';

enum HomeAdmStateStatus {
  loaded, 
  error 
}

class HomeAdmState {
  final HomeAdmStateStatus status;
  final List<UserModel> employees;
  //final List<EmployeeUserModel> modelEmployees;//

    HomeAdmState({
    required this.status,
    required this.employees,
    //required this.modelEmployees,//
  });

  HomeAdmState copyWith({
    HomeAdmStateStatus? status,
    List<UserModel>? employees,    
    //List<EmployeeUserModel>? modelEmployees//
  }) {
    return HomeAdmState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
      //modelEmployees: modelEmployees ?? this.modelEmployees//
    );
  }
}