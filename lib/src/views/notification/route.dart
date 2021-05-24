part of view.notification;

class NotifyRoute extends AppRoute {
  static const String _notify = NotifyView.routeName;
  static const String test = TestView.routeName;

  final List<GetPage> _pages = <GetPage>[
    GetPage<Object>(
      name: _notify,
      page: () => const NotifyView(),
      transition: Transition.fadeIn,
    ),
    GetPage<Object>(
      name: test,
      page: () => const TestView(),
    ),
  ];

  @override
  int get id => 5;

  @override
  String get index => _notify;

  @override
  List<GetPage> get pages => _pages;
}