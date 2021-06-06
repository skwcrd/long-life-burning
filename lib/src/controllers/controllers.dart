library controller;

import 'dart:io'
  show Platform;

import 'package:flutter/foundation.dart'
  show kIsWeb;
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'
  show
    User,
    FirebaseAuthException;
import 'package:firebase_messaging/firebase_messaging.dart'
  show RemoteMessage;

import '../models/models.dart';
import '../route.dart'
  show AppRoute;
import '../services/services.dart';
import '../utils/utils.dart'
  show AppIcon;

part '_app.dart';
part '_web.dart';
part '_desktop.dart';

part 'auth.dart';
part 'event.dart';
part 'group.dart';
part 'home.dart';
part 'menu.dart';
part 'nearby.dart';
part 'notification.dart';

part 'bindings/bindings.dart';
part 'bindings/event.dart';
part 'bindings/group.dart';
part 'bindings/home.dart';
part 'bindings/menu.dart';
part 'bindings/nearby.dart';
part 'bindings/notification.dart';