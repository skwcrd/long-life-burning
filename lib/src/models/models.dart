library model;

import 'package:flutter/foundation.dart'
  show ValueChanged;
import 'package:flutter/widgets.dart'
  show
    Icon,
    IconData,
    NavigatorObserver,
    BottomNavigationBarItem;

import 'package:get/get.dart'
  show
    Get,
    Routing,
    GetObserver,
    GetNavigation;

import '../services/firebase/firebase.dart'
  show FirebaseService;
import '../views/views.dart'
  show AppRoute;

part 'nav.dart';