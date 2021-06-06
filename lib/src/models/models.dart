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

import '../route.dart'
  show AppRoute;
import '../services/report/report.dart';
import '../utils/utils.dart';

part 'event.dart';
part 'group.dart';
part 'navigation.dart';
part 'notification.dart';
part 'record.dart';