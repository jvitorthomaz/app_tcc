
class SchedulesModel {
  final int id;
  final int placeId;
  final int userId;
  final int hour;
  final String clientName;
  final String? scheduleNote;
  final DateTime date;

  SchedulesModel( {
    required this.id,
    required this.placeId,
    required this.userId,
    required this.clientName,
    this.scheduleNote,
    required this.date,
    required this.hour,
  });

  factory SchedulesModel.fromMap(Map<String, dynamic> json) {
    switch (json) {

      //recebe 
      case {
        'id': int id,
        'place_id': int placeId,
        'user_id': int userId,
        'client_name': String clientName,
        'schedule_note': String scheduleNote,
        'date': String scheduleDate,
        'time': int hour,
      }:

      //retorna
      return SchedulesModel(
        id: id,
        placeId: placeId,
        userId: userId,
        clientName: clientName,
        scheduleNote: scheduleNote,
        date: DateTime.parse(scheduleDate),
        hour: hour,
      );
      case _:
        throw ArgumentError('Invalid JSON: $json');
    }
  }
}
