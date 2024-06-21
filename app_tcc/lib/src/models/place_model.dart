
class PlaceModel {
  final int id;
  final String name;
  final String email;
  final List<String> openingDays;
  final List<int> openingHours;

  PlaceModel({
    required this.id,
    required this.name,
    required this.email,
    required this.openingDays,
    required this.openingHours,
  });

  factory PlaceModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      //valida json
      {
        'id': int id,
        'name': String name,
        'email': String email,
        'opening_days': final List openingDays,
        'opening_hours': final List openingHours,
      } =>
      //Se passar, retorna model
        PlaceModel(
          id: id,
          name: name,
          email: email,
          openingDays: openingDays.cast<String>(),
          openingHours: openingHours.cast<int>(),
        ),
        // Se não passar, lança o erro
        _ => throw ArgumentError('Invalid Error')
    };
  }

}
