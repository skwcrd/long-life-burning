library controller;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';
import '../services/firebase/firebase.dart';
import '../utils/utils.dart'
  show AppIcon;
import '../views/views.dart'
  show AppRoute;

part 'auth.dart';

part 'bindings/bindings.dart';

class AppController extends GetxController {
  AppController._()
    : _index = 0.obs,
      _navigator = [
        NavBarModel(
          label: 'Home',
          title: 'Home',
          route: AppRoute.home,
          icon: AppIcon.home),
        NavBarModel(
          label: 'Near by me',
          title: 'Nearby',
          route: AppRoute.nearby,
          icon: AppIcon.nearby),
        NavBarModel(
          label: 'Event',
          title: 'Event',
          route: AppRoute.event,
          icon: AppIcon.event),
        NavBarModel(
          label: 'Group',
          title: 'Group',
          route: AppRoute.group,
          icon: AppIcon.group),
        NavBarModel(
          label: 'Notification',
          title: 'Notify',
          route: AppRoute.notify,
          icon: AppIcon.notify),
        NavBarModel(
          label: 'Menu',
          title: 'Menu',
          route: AppRoute.menu,
          icon: AppIcon.menu),
      ],
      super();

  final RxInt _index;
  final List<NavBarModel> _navigator;

  late final List<int> _id;
  late final List<Widget> _pageItems;
  late final List<BottomNavigationBarItem> _navItems;

  RxInt get index => _index;

  List<int> get id => _id;
  List<Widget> get pageItems => _pageItems;
  List<BottomNavigationBarItem> get navItems => _navItems;

  @override
  void onInit() {
    super.onInit();
    /// The application's top-level routing table.
    /// [routes] routing other pages in application.
    /// can edit [routeName] in class define on page class.
    Get.addPages([
      for ( final _nav in _navigator )
        ..._nav.route.pages,
    ]);

    _id = <int>[
      for ( final _nav in _navigator )
        _nav.id,
    ];

    _navItems = <BottomNavigationBarItem>[
      for ( final _nav in _navigator )
        _nav.item,
    ];

    _pageItems = List.generate(
      _navigator.length,
      (i) => Obx(
        () => Offstage(
          offstage: _index.value != i,
          child: Navigator(
            key: Get.nestedKey(_navigator[i].id),
            /// The name of the first route to show,
            /// if a [Navigator] is built.
            /// (start with index page)
            initialRoute: _navigator[i].route.index,
            onGenerateRoute: (settings) => PageRedirect(
              settings, null).page<Object>(),
            onGenerateInitialRoutes: (navigator, initialRoute) => [
              PageRedirect(
                RouteSettings(name: initialRoute),
                null).page<Object>(),
            ],
            reportsRouteUpdateToEngine: true,
            restorationScopeId: _navigator[i].label,
          ),
        ),
      ));
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {
    super.onClose();
    _index.close();
  }
}