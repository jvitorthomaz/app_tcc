sealed class UserModel {
  final int id;
  final String? firebaseUUID;
  final String? profileFileName;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.firebaseUUID,
    required this.profileFileName,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json['profile']) {

      'ADM' => AdmUserModel.fromMap(json),
      'EMPLOYEE' => EmployeeUserModel.fromMap(json),
      _ => throw FormatException('Invalid UserModel JSON: $json')

    };
  }
}

final class AdmUserModel extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  AdmUserModel({
    required super.id,
    super.firebaseUUID,
    super.profileFileName,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours, 
  });

  factory AdmUserModel.fromMap(Map<String, dynamic> json) {
    // Validação do json que esta vindo do backend
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,

      } =>
        AdmUserModel(
          id: id,
          name: name,
          email: email,
          firebaseUUID: json['firebase_UUID'],
          profileFileName: json['profile_file_name'],
          avatar: json['avatar'],
          workDays: json['work_days']?.cast<String>(),
          workHours: json['work_hours']?.cast<int>(), 
          
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }

}

final class EmployeeUserModel extends UserModel {
  final int placeId;
  final List<String> workDays;
  final List<int> workHours;

  EmployeeUserModel({
    required super.id,
    super.firebaseUUID,
    super.profileFileName,
    required super.name,
    required super.email,
    required this.placeId,
    required this.workDays,
    required this.workHours,
    super.avatar, 
  });

  factory EmployeeUserModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'place_id': final int placeId,
        'work_days': final List workDays,
        'work_hours': final List workHours,
      } =>
        EmployeeUserModel(
          id: id,
          name: name,
          email: email,
          firebaseUUID: json['firebase_UUID'],
          profileFileName: json['profile_file_name'],
          workDays: workDays.cast<String>(),
          workHours: workHours.cast<int>(),
          avatar: json['avatar'],
          placeId: placeId, 
        ),
      _ => throw ArgumentError('Invalid EmployeeUserModel JSON: $json'),
    };
  }
}
