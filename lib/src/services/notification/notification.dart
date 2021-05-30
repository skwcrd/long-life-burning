library service.notification;

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'cloud.dart';
part 'local.dart';

const String _kThreadIdentifier =
    'com.skwcrd.long_life_burning.ios.threadIdentifier';

const String _kChannelId =
    'com.skwcrd.long_life_burning.notifyChannel';
const String _kChannelName =
    'Long Life Burning';
const String _kChannelDescription =
    'Application community for workout';

class NotifyService {
  NotifyService._(this._cloud, this._local);

  static NotifyService? _instance;

  /// Singleton instance of DatabaseService.
  // ignore: prefer_constructors_over_static_methods
  static NotifyService? get instance => _instance;

  final _CloudNotifyService _cloud;
  final _LocalNotifyService? _local;

  static Future<NotifyService> init({
    String? channelId,
    String? channelName,
    String? channelDescription,
    SelectNotificationCallback? onSelectNotification,
    DidReceiveLocalNotificationCallback? onDidReceiveLocalNotification,
  }) =>
      _LocalNotifyService
        ._init(
          channelId: channelId,
          channelName: channelName,
          channelDescription: channelDescription,
          onSelectNotification: onSelectNotification,
          onDidReceiveLocalNotification: onDidReceiveLocalNotification)
        .then(
          (value) => _instance ??= NotifyService._(
            _CloudNotifyService._(), value));
}