part of view.nearby;

class NearbyRoute extends AppRoute {
  static const String _nearby = NearbyView.routeName;
  static const String test = TestView.routeName;

  static final List<GetPage> _pages = <GetPage>[
    GetPage<Object>(
      name: _nearby,
      page: () => const NearbyView(),
    ),
    GetPage<Object>(
      name: test,
      page: () => const TestView(),
    ),
  ];

  @override
  int get id => 2;

  @override
  String get index => _nearby;

  @override
  List<GetPage> get pages => _pages;
}