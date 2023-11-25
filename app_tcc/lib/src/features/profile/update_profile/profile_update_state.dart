
enum ProfileUpdateStateStatus {
  initial, 
  success, 
  error 
}


class ProfileUpdateState {
  final ProfileUpdateStateStatus status;
  // final bool updateAdm;
  final List<String> workdays;
  final List<int> workhours;

  ProfileUpdateState.initial() : this(
    status: ProfileUpdateStateStatus.initial,
    // updateAdm: false,
    workdays: <String>[],
    workhours: <int>[],
  );

  ProfileUpdateState({
    required this.status,
    // required this.updateAdm,
    required this.workdays,
    required this.workhours,
  });

  ProfileUpdateState copyWith({
    ProfileUpdateStateStatus? status,
    // bool? updateAdm,
    List<String>? workdays,
    List<int>? workhours,
  }) {
    return ProfileUpdateState(
      status: status ?? this.status,
      // updateAdm: updateAdm ?? this.updateAdm,
      workdays: workdays ?? this.workdays,
      workhours: workhours ?? this.workhours,
    );
  }
}
