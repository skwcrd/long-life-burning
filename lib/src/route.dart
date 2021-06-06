library application.route;

import 'package:get/get.dart'
  show GetPage;

import 'views/event/event.dart'
  show EventRoute;
import 'views/group/group.dart'
  show GroupRoute;
import 'views/home/home.dart'
  show HomeRoute;
import 'views/menu/menu.dart'
  show MenuRoute;
import 'views/nearby/nearby.dart'
  show NearbyRoute;
import 'views/notification/notification.dart'
  show NotifyRoute;

abstract class AppRoute {
  const AppRoute();

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