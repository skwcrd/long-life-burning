part of model;

class NavBarModel {
  NavBarModel({
    required this.label,
    required this.route,
    String? title,
    IconData? icon,
  }) :  id = route.id,
        item = BottomNavigationBarItem(
          icon: Icon(icon),
          label: title ?? label);

  final int id;
  final String label;
  final AppRoute route;
  final BottomNavigationBarItem item;

  @override
  String toString() =>
      "[NavBarModel] id: $id, label: $label";
}