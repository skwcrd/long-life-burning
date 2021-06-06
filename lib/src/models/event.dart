part of model;

class EventModel {
  EventModel._({
    required this.id,
    required this.type,
    required this.province,
    required this.title,
    required this.subtitle,
    required this.detail,
    // this.locateName,
    // this.location,
    required this.dateTime,
    required this.price,
    // this.users,
  });

  factory EventModel.fromMap(Map<String, dynamic> data) =>
    EventModel._(
      id: data["id"].toString(),
      type: EventType.values.firstWhere(
        (e) => e.value == data["type"]),
      province: ProvinceType.values.firstWhere(
        (e) => e.value == data["province"]),
      title: data["title"].toString(),
      subtitle: data["subtitle"].toString(),
      detail: data["detail"].toString(),
      // locateName: data["locateName"],
      // location: data["location"],
      dateTime: DateTime.tryParse(data["dateTime"].toString())!,
      price: num.tryParse(data["price"].toString())!,
      // users: data["users"],
    );

  factory EventModel.fromJson(String data) =>
      EventModel.fromMap(
        json.decode(data) as Map<String, dynamic>);

  final String id;
  final EventType type;
  final ProvinceType province;
  final String title;
  final String subtitle;
  final String detail;
  // final String locateName;
  // final GeoPoint location;
  final DateTime dateTime;
  final num price;
  // final List users;

  Map<String, dynamic> toMap() =>
      <String, dynamic>{
        "id": id,
        'type': type.value,
        "province": province.value,
        "title": title,
        "subtitle": subtitle,
        "detail": detail,
        // "locateName": locateName,
        // "location": location,
        'dateTime': dateTime,
        "price": price,
        // "users": users,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      "[EventModel] "
      "id: $id, "
      "type: ${type.value}, "
      "province: ${province.value}, "
      "title: $title, "
      "subtitle: $subtitle, "
      "detail: $detail, "
      // "locateName: $locateName, "
      // "location: $location, "
      "dateTime: $dateTime, "
      "price: $price";
}