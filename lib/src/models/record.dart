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
        id: num.tryParse(data["id"])!,
        step: num.tryParse(data["step"])!,
        calories: num.tryParse(data["calories"])!,
        distance: num.tryParse(data["distance"])!,
        avgPace: Duration(
          microseconds: int.tryParse(data["avgPace"])!),
        duration: Duration(
          microseconds: int.tryParse(data["duration"])!),
        dateTime: DateTime.tryParse(data["dateTime"])!);

  factory RecordModel.fromJson(String data) =>
      RecordModel.fromMap(json.decode(data));

  final num id;
  final num step;
  final num calories;
  final num distance;
  final Duration avgPace;
  final Duration duration;
  final DateTime dateTime;

  Map<String, dynamic> toMap() =>
      {
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