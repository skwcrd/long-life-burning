part of service.notification;

class _CloudNotifyService {
  _CloudNotifyService._(this._notify);

  final FirebaseMessaging _notify;

  NotificationSettings? _settings;

  static Future<_CloudNotifyService> _init({
    bool? autoInitEnabled,
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
  }) async {
    final _notify = FirebaseMessaging.instance;

    await _notify.requestPermission(
      alert: alert,
      announcement: announcement,
      badge: badge,
      carPlay: carPlay,
      criticalAlert: criticalAlert,
      provisional: provisional,
      sound: sound);

    if ( autoInitEnabled != null ) {
      await _notify.setAutoInitEnabled(autoInitEnabled);
    }

    await _notify.setForegroundNotificationPresentationOptions(
      alert: alert,
      badge: badge,
      sound: sound);

    return _CloudNotifyService._(_notify);
  }

  Future<NotificationSettings> get settings async =>
      _settings ??= await _notify.getNotificationSettings();

  Future<String?> getToken({ String? vapidKey }) =>
      _notify.getToken(vapidKey: vapidKey);

  Stream<String> get token =>
      _notify.onTokenRefresh;

  Stream<RemoteMessage> get message =>
      FirebaseMessaging.onMessage;

  Stream<RemoteMessage> get messageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  Future<void> deleteToken() =>
      _notify.deleteToken();
}