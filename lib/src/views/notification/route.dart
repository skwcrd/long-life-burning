part of view.notification;

class NotifyRoute implements AppRoute {
  NotifyRoute()
    : _pages = [
        GetPage<void>(
          name: _notify,
          page: () => const NotifyView(),
          binding: NotifyBinding(),
        ),
        GetPage<void>(
          name: test,
          page: () => const _TestView(),
        ),
      ],
      super();

  static const String _notify = NotifyView.routeName;
  static const String test = _TestView.routeName;

  final List<GetPage> _pages;

  @override
  int get id => 5;

  @override
  String get index => _notify;

  @override
  List<GetPage> get pages => _pages;
}