library model;

import 'dart:convert'
  show json;

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
// import 'package:cloud_firestore/cloud_firestore.dart'
//   show
//     GeoPoint,
//     Timestamp;

import '../services/firebase/firebase.dart'
  show FirebaseService;
import '../utils/utils.dart';
import '../views/views.dart'
  show AppRoute;

part 'event.dart';
part 'group.dart';
part 'navigation.dart';
part 'notification.dart';
part 'record.dart';