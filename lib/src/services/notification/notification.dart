library service.notification;

import 'dart:typed_data'
  show
    Int32List,
    Int64List;
import 'dart:ui'
  show Color;

import 'package:firebase_messaging/firebase_messaging.dart'
  show
    RemoteMessage,
    FirebaseMessaging,
    NotificationSettings;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../utils/utils.dart'
  show InstanceException;

part 'cloud.dart';
part 'local.dart';

Future<void> _fetchMessageOnBackgroundHandler(RemoteMessage message) async {
}

class NotifyService {
  NotifyService._(this._cloud, this._local) {
    _initialized = true;
  }

  static bool _initialized = false;
  static NotifyService? _instance;

  /// Singleton instance of NotifyService.
  // ignore: prefer_constructors_over_static_methods
  static NotifyService get instance {
    if ( _instance == null ) {
      throw InstanceException(
        className: 'NotifyService',
        message: 'Please called [NotifyService.init] before get instance this class');
    }

    return _instance!;
  }

  final _CloudNotifyService _cloud;
  final _LocalNotifyService? _local;

  static Future<NotifyService> init({
    String defaultAndroidIcon = 'ic_launcher',
    bool? autoInitEnabled,
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
    bool requestAlertPermission = true,
    bool requestSoundPermission = true,
    bool requestBadgePermission = true,
    bool defaultPresentAlert = true,
    bool defaultPresentSound = true,
    bool defaultPresentBadge = true,
    SelectNotificationCallback? onSelectNotification,
    DidReceiveLocalNotificationCallback? onDidReceiveLocalNotification,
  }) async {
    if ( !_initialized ) {
      FirebaseMessaging.onBackgroundMessage(
        _fetchMessageOnBackgroundHandler);

      final _cloud = await _CloudNotifyService._init(
        autoInitEnabled: autoInitEnabled,
        alert: alert,
        announcement: announcement,
        badge: badge,
        carPlay: carPlay,
        criticalAlert: criticalAlert,
        provisional: provisional,
        sound: sound);

      final _local = await _LocalNotifyService._init(
        defaultAndroidIcon: defaultAndroidIcon,
        requestAlertPermission: requestAlertPermission,
        requestSoundPermission: requestSoundPermission,
        requestBadgePermission: requestBadgePermission,
        defaultPresentAlert: defaultPresentAlert,
        defaultPresentSound: defaultPresentSound,
        defaultPresentBadge: defaultPresentBadge,
        onSelectNotification: onSelectNotification,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

      _instance = NotifyService._(_cloud, _local);
    }

    return _instance!;
  }

  Future<String?> getToken({ String? vapidKey }) =>
      _cloud.getToken(vapidKey: vapidKey);

  Stream<String> get token => _cloud.token;
  Stream<RemoteMessage> get message => _cloud.message;
  Stream<RemoteMessage> get messageOpenedApp => _cloud.messageOpenedApp;

  Future<void> show({
    required int id,
    String? title,
    String? body,
    NotificationDetails? details,
    String? payload,
  }) async {
    await _local?.show(
      id: id,
      title: title,
      body: body,
      details: details,
      payload: payload);
  }
}