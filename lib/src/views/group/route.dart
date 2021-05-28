part of view.group;

class GroupRoute extends AppRoute {
  static const String _group = GroupView.routeName;
  static const String test = TestView.routeName;

  static final List<GetPage> _pages = <GetPage>[
    GetPage<Object>(
      name: _group,
      page: () => const GroupView(),
      binding: GroupBinding(),
    ),
    GetPage<Object>(
      name: test,
      page: () => const TestView(),
    ),
  ];

  @override
  int get id => 4;

  @override
  String get index => _group;

  @override
  List<GetPage> get pages => _pages;
}