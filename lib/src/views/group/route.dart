part of view.group;

class GroupRoute implements AppRoute {
  GroupRoute()
    : _pages = [
        GetPage<void>(
          name: _group,
          page: () => const GroupView(),
          binding: GroupBinding(),
        ),
        GetPage<void>(
          name: test,
          page: () => const _TestView(),
        ),
      ],
      super();

  static const String _group = GroupView.routeName;
  static const String test = _TestView.routeName;

  final List<GetPage> _pages;

  @override
  int get id => 4;

  @override
  String get index => _group;

  @override
  List<GetPage> get pages => _pages;
}