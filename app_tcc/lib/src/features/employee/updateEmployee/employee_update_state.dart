
enum EmployeeUpdateStateStatus {
  initial, 
  success, 
  error 
}


class EmployeeUpdateState {
  final EmployeeUpdateStateStatus status;
  final bool updateAdm;
  final List<String> workdays;
  final List<int> workhours;

  EmployeeUpdateState.initial() : this(
    status: EmployeeUpdateStateStatus.initial,
    updateAdm: false,
    workdays: <String>[],
    workhours: <int>[],
  );

  EmployeeUpdateState({
    required this.status,
    required this.updateAdm,
    required this.workdays,
    required this.workhours,
  });

  EmployeeUpdateState copyWith({
    EmployeeUpdateStateStatus? status,
    bool? updateAdm,
    List<String>? workdays,
    List<int>? workhours,
  }) {
    return EmployeeUpdateState(
      status: status ?? this.status,
      updateAdm: updateAdm ?? this.updateAdm,
      workdays: workdays ?? this.workdays,
      workhours: workhours ?? this.workhours,
    );
  }
}
