part of view.home;

class HomeRoute implements AppRoute {
  HomeRoute()
    : _pages = [
        GetPage<void>(
          name: _home,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
        GetPage<void>(
          name: test,
          page: () => const _TestView(),
        ),
      ],
      super();

  static const String _home = HomeView.routeName;
  static const String test = _TestView.routeName;

  final List<GetPage> _pages;

  @override
  int get id => 1;

  @override
  String get index => _home;

  @override
  List<GetPage> get pages => _pages;
}