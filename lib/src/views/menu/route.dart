part of view.menu;

class MenuRoute extends AppRoute {
  static const String _menu = MenuView.routeName;
  static const String test = TestView.routeName;

  static final List<GetPage> _pages = <GetPage>[
    GetPage<Object>(
      name: _menu,
      page: () => const MenuView(),
      binding: MenuBinding(),
    ),
    GetPage<Object>(
      name: test,
      page: () => const TestView(),
    ),
  ];

  @override
  int get id => 6;

  @override
  String get index => _menu;

  @override
  List<GetPage> get pages => _pages;
}