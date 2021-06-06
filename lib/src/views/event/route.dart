part of view.event;

class EventRoute implements AppRoute {
  EventRoute()
    : _pages = [
        GetPage<void>(
          name: _event,
          page: () => const EventView(),
          binding: EventBinding(),
        ),
        GetPage<void>(
          name: test,
          page: () => const _TestView(),
        ),
      ],
      super();

  static const String _event = EventView.routeName;
  static const String test = _TestView.routeName;

  final List<GetPage> _pages;

  @override
  int get id => 3;

  @override
  String get index => _event;

  @override
  List<GetPage> get pages => _pages;
}