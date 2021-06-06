part of view.nearby;

class NearbyRoute implements AppRoute {
  NearbyRoute()
    : _pages = [
        GetPage<void>(
          name: _nearby,
          page: () => const NearbyView(),
          binding: NearbyBinding(),
        ),
        GetPage<void>(
          name: test,
          page: () => const _TestView(),
        ),
      ],
      super();

  static const String _nearby = NearbyView.routeName;
  static const String test = _TestView.routeName;

  final List<GetPage> _pages;

  @override
  int get id => 2;

  @override
  String get index => _nearby;

  @override
  List<GetPage> get pages => _pages;
}