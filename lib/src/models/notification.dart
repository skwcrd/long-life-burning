part of model;

class NotifyModel {
  NotifyModel._({
    required this.id,
    required this.title,
    required this.body,
    required this.dateTime,
  });

  factory NotifyModel.fromMap(Map<String, dynamic> data) =>
      NotifyModel._(
        id: num.tryParse(data["id"].toString())!,
        title: data["title"].toString(),
        body: data["body"].toString(),
        dateTime: DateTime.tryParse(data["dateTime"].toString())!);

  factory NotifyModel.fromJson(String data) =>
      NotifyModel.fromMap(
        json.decode(data) as Map<String, dynamic>);

  final num id;
  final String title;
  final String body;
  final DateTime dateTime;

  Map<String, dynamic> toMap() =>
      <String, dynamic>{
        "id": id,
        "title": title,
        "body": body,
        'dateTime': dateTime,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      "[NotifyModel] "
      "id: $id, "
      "title: $title, "
      "body: $body, "
      "dateTime: $dateTime";
}