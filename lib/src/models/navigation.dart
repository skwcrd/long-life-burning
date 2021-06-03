part of model;

class NavBarModel {
  NavBarModel({
    required this.label,
    required this.route,
    String? title,
    IconData? icon,
    ValueChanged<Routing?>? routingCallback,
  }) :  id = route.id,
        observers = <NavigatorObserver>[
          ReportService.observer,
          GetObserver(routingCallback, Get.routing),
        ],
        item = BottomNavigationBarItem(
          icon: Icon(icon),
          label: title ?? label);

  final int id;
  final String label;
  final AppRoute route;
  final List<NavigatorObserver> observers;
  final BottomNavigationBarItem item;

  @override
  String toString() =>
      "[NavBarModel] id: $id, label: $label";
}