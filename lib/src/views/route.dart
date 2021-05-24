part of view;

abstract class AppRoute {
  static final home = HomeRoute();
  static final nearby = NearbyRoute();
  static final event = EventRoute();
  static final group = GroupRoute();
  static final notify = NotifyRoute();
  static final menu = MenuRoute();

  int get id {
    throw UnimplementedError('id is not implemented');
  }

  String get index {
    throw UnimplementedError('index is not implemented');
  }

  List<GetPage> get pages {
    throw UnimplementedError('pages is not implemented');
  }
}