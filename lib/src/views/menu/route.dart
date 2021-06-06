part of view.menu;

class MenuRoute implements AppRoute {
  MenuRoute()
    : _pages = [
        GetPage<void>(
          name: _menu,
          page: () => const MenuView(),
          binding: MenuBinding(),
        ),
        GetPage<void>(
          name: test,
          page: () => const _TestView(),
        ),
      ],
      super();

  static const String _menu = MenuView.routeName;
  static const String test = _TestView.routeName;

  final List<GetPage> _pages;

  @override
  int get id => 6;

  @override
  String get index => _menu;

  @override
  List<GetPage> get pages => _pages;
}