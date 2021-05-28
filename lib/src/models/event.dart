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
      id: data["id"],
      type: EventType.values.firstWhere(
        (e) => e.value == data["type"]),
      province: ProvinceType.values.firstWhere(
        (e) => e.value == data["province"]),
      title: data["title"],
      subtitle: data["subtitle"],
      detail: data["detail"],
      // locateName: data["locateName"],
      // location: data["location"],
      dateTime: DateTime.tryParse(data["dateTime"])!,
      price: num.tryParse(data["price"])!,
      // users: data["users"],
    );

  factory EventModel.fromJson(String data) =>
      EventModel.fromMap(json.decode(data));

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
      {
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