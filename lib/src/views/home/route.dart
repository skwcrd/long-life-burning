part of view.home;

class HomeRoute extends AppRoute {
  static const String _home = HomeView.routeName;
  static const String test = TestView.routeName;

  final List<GetPage> _pages = <GetPage>[
    GetPage<Object>(
      name: _home,
      page: () => const HomeView(),
    ),
    GetPage<Object>(
      name: test,
      page: () => const TestView(),
    ),
  ];

  @override
  int get id => 1;

  @override
  String get index => _home;

  @override
  List<GetPage> get pages => _pages;
}