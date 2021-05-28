part of model;

class GroupModel {
  GroupModel._({
    required this.id,
    required this.name,
    required this.type,
    required this.dateTime,
    // required this.location,
    // required this.users,
  });

  factory GroupModel.fromMap(Map<String, dynamic> data) =>
    GroupModel._(
      id: data["id"],
      name: data["name"],
      type: GroupType.values.firstWhere(
        (e) => e.value == data["type"]),
      dateTime: DateTime.tryParse(data["dateTime"])!,
      // location: data["location"],
      // users: data["users"],
    );

  factory GroupModel.fromJson(String data) =>
      GroupModel.fromMap(json.decode(data));

  final String id;
  final String name;
  final GroupType type;
  final DateTime dateTime;
  // final GeoPoint location;
  // final List users;

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "name": name,
        'type': type.value,
        'dateTime': dateTime,
        // "location": location,
        // "users": users,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      "[GroupModel] "
      "id: $id, "
      "name: $name, "
      "type: ${type.value}, "
      "dateTime: $dateTime";
}