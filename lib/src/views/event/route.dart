part of view.event;

class EventRoute extends AppRoute {
  static const String _event = EventView.routeName;
  static const String test = TestView.routeName;

  static final List<GetPage> _pages = <GetPage>[
    GetPage<Object>(
      name: _event,
      page: () => const EventView(),
      binding: EventBinding(),
    ),
    GetPage<Object>(
      name: test,
      page: () => const TestView(),
    ),
  ];

  @override
  int get id => 3;

  @override
  String get index => _event;

  @override
  List<GetPage> get pages => _pages;
}