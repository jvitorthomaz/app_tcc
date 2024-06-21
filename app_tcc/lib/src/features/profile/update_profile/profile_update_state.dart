
enum ProfileUpdateStateStatus {
  initial, 
  success, 
  error 
}


class ProfileUpdateState {
  final ProfileUpdateStateStatus status;
  final List<String> workdays;
  final List<int> workhours;

  ProfileUpdateState.initial() : this(
    status: ProfileUpdateStateStatus.initial,
    workdays: <String>[],
    workhours: <int>[],
  );

  ProfileUpdateState({
    required this.status,
    required this.workdays,
    required this.workhours,
  });

  ProfileUpdateState copyWith({
    ProfileUpdateStateStatus? status,
    List<String>? workdays,
    List<int>? workhours,
  }) {
    return ProfileUpdateState(
      status: status ?? this.status,
      workdays: workdays ?? this.workdays,
      workhours: workhours ?? this.workhours,
    );
  }
}
