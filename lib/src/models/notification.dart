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
        id: num.tryParse(data["id"])!,
        title: data["title"],
        body: data["body"],
        dateTime: DateTime.tryParse(data["dateTime"])!);

  factory NotifyModel.fromJson(String data) =>
      NotifyModel.fromMap(json.decode(data));

  final num id;
  final String title;
  final String body;
  final DateTime dateTime;

  Map<String, dynamic> toMap() =>
      {
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