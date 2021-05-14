part of app;

class AppRoute {
  AppRoute._();

  static const String index = IndexView.routeName;

  static final List<GetPage> pages = <GetPage>[
    GetPage<Object>(
      name: index,
      page: () => const IndexView(),
      transition: Transition.fadeIn,
    ),
  ];
}