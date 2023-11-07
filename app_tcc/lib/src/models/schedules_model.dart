
class SchedulesModel {
    SchedulesModel({
    required this.id,
    required this.placeId,
    required this.userId,
    required this.clientName,
    required this.date,
    required this.hour,
  });

  factory SchedulesModel.fromMap(Map<String, dynamic> json) {
    switch (json) {
      case {
        'id': int id,
        'place_id': int placeId,
        'user_id': int userId,
        'client_name': String clientName,
        'date': String scheduleDate,
        'time': int hour,
      }:
      return SchedulesModel(
        id: id,
        placeId: placeId,
        userId: userId,
        clientName: clientName,
        date: DateTime.parse(scheduleDate),
        hour: hour,
      );
      case _:
        throw ArgumentError('Invalid JSON: $json');
    }
  }

  final int id, placeId, userId, hour;
  final String clientName;
  final DateTime date;
}
