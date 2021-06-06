part of model;

class RecordModel {
  RecordModel._({
    required this.id,
    required this.step,
    required this.calories,
    required this.distance,
    required this.avgPace,
    required this.duration,
    required this.dateTime,
  });

  factory RecordModel.fromMap(Map<String, dynamic> data) =>
      RecordModel._(
        id: num.tryParse(data["id"].toString())!,
        step: num.tryParse(data["step"].toString())!,
        calories: num.tryParse(data["calories"].toString())!,
        distance: num.tryParse(data["distance"].toString())!,
        avgPace: Duration(
          microseconds: int.tryParse(data["avgPace"].toString())!),
        duration: Duration(
          microseconds: int.tryParse(data["duration"].toString())!),
        dateTime: DateTime.tryParse(data["dateTime"].toString())!);

  factory RecordModel.fromJson(String data) =>
      RecordModel.fromMap(
        json.decode(data) as Map<String, dynamic>);

  final num id;
  final num step;
  final num calories;
  final num distance;
  final Duration avgPace;
  final Duration duration;
  final DateTime dateTime;

  Map<String, dynamic> toMap() =>
      <String, dynamic>{
        "id": id,
        "step": step,
        "calories": calories,
        "distance": distance,
        "avgPace": avgPace.inMicroseconds,
        "duration": duration.inMicroseconds,
        'dateTime': dateTime,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      "[RecordModel] "
      "id: $id, "
      "step: $step, "
      "calories: $calories, "
      "distance: $distance, "
      "avgPace: $avgPace, "
      "duration: $duration, "
      "dateTime: $dateTime";
}