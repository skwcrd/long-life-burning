library controller;

import 'package:flutter/foundation.dart'
  show required;
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';
import '../services/firebase/firebase.dart';
import '../utils/utils.dart'
  show AppIcon;

part 'auth.dart';

part 'bindings/bindings.dart';

class AppController extends GetxController {
  AppController._()
    : _index = 0.obs,
      _navigator = [
        NavBarModel(
          id: 1,
          item: BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(AppIcon.home),
          )),
        NavBarModel(
          id: 2,
          item: BottomNavigationBarItem(
            label: 'Nearby',
            icon: Icon(AppIcon.nearMe),
          )),
        NavBarModel(
          id: 3,
          item: BottomNavigationBarItem(
            label: 'Event',
            icon: Icon(AppIcon.event),
          )),
        NavBarModel(
          id: 4,
          item: BottomNavigationBarItem(
            label: 'Group',
            icon: Icon(AppIcon.group),
          )),
        NavBarModel(
          id: 5,
          item: BottomNavigationBarItem(
            label: 'Notify',
            icon: Icon(AppIcon.notify),
          )),
        NavBarModel(
          id: 6,
          item: BottomNavigationBarItem(
            label: 'Menu',
            icon: Icon(AppIcon.menu),
          )),
      ],
      super();

  final RxInt _index;
  final List<NavBarModel> _navigator;

  int get index => _index.value;

  List<BottomNavigationBarItem> get navItems =>
      _navigator.map<BottomNavigationBarItem>((n) => n.item).toList();

  @override
  void onInit() {
    super.onInit();
    for ( final _nav in _navigator ) {
      Get.nestedKey(_nav.id);
    }
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

  void changeIndex(int i) {
    _index.call(i);
    // update();
  }
}