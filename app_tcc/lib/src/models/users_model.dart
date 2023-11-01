sealed class UserModel {
  final int id;
  final String name;
  final String email;
  //final String cpf;
  //final String telefone;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    //required this.cpf,
    //required this.telefone,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json['profile']) {
      'ADM' => UserModelAdm.fromMap(json),
      'EMPLOYEE' => UserModelEmployee.fromMap(json),
      _ => throw FormatException('Invalid UserModel JSON: $json')
    };
  }
}

final class UserModelAdm extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserModelAdm({
    required super.id,
    required super.name,
    required super.email,
    //required super.cpf,
    //required super.telefone, 
    super.avatar,
    this.workDays,
    this.workHours, 
  });

  factory UserModelAdm.fromMap(Map<String, dynamic> json) {
    // Validação do json que esta vindo do backend
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        //'cpf': final String cpf,
        //'telefone': final String telefone,

      } =>
        UserModelAdm(
          id: id,
          name: name,
          email: email,
          //cpf: cpf,
          //telefone: telefone,
          avatar: json['avatar'],
          workDays: json['work_days']?.cast<String>(),
          workHours: json['work_hours']?.cast<int>(), 
          
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }

}

final class UserModelEmployee extends UserModel {
  final int placeId;
  final List<String> workDays;
  final List<int> workHours;

  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    //required super.cpf,
    //required super.telefone,
    required this.placeId,
    required this.workDays,
    required this.workHours,
    super.avatar, 
  });

  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        //'cpf': final String cpf,
        //'telefone': final String telefone,
        'place_id': final int placeId,
        'work_days': final List workDays,
        'work_hours': final List workHours,
      } =>
        UserModelEmployee(
          id: id,
          name: name,
          email: email,
          //cpf: cpf,
          //telefone: telefone,
          workDays: workDays.cast<String>(),
          workHours: workHours.cast<int>(),
          avatar: json['avatar'],
          placeId: placeId, 
        ),
      _ => throw ArgumentError('Invalid UserModelEmployee JSON: $json'),
    };
  }
}
