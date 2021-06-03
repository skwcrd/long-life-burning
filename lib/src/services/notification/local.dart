part of service.notification;

class _LocalNotifyService {
  _LocalNotifyService._(this._plugin) {
    _details = getNotificationDetails(
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      presentAlert: true,
      presentBadge: true,
      presentSound: true);
  }

  static const String _kThreadIdentifier =
      'com.skwcrd.long_life_burning.ios.threadIdentifier';

  static const String _kChannelId =
      'com.skwcrd.long_life_burning.messaging.notification_channel_id';
  static const String _kChannelName =
      'Long Life Burning';
  static const String _kChannelDescription =
      'Application community for workout';

  static Future<_LocalNotifyService?> _init({
    String defaultAndroidIcon = 'ic_launcher',
    bool requestAlertPermission = true,
    bool requestSoundPermission = true,
    bool requestBadgePermission = true,
    bool defaultPresentAlert = true,
    bool defaultPresentSound = true,
    bool defaultPresentBadge = true,
    SelectNotificationCallback? onSelectNotification,
    DidReceiveLocalNotificationCallback? onDidReceiveLocalNotification,
  }) {
    final _notifyPlugin = FlutterLocalNotificationsPlugin();

    // Initialise the plugin. app_icon needs to be a added as
    // a drawable resource to the Android head project
    final AndroidInitializationSettings _settingAndroid =
        AndroidInitializationSettings(defaultAndroidIcon);
    final IOSInitializationSettings _settingIOS =
        IOSInitializationSettings(
          requestAlertPermission: requestAlertPermission,
          requestSoundPermission: requestSoundPermission,
          requestBadgePermission: requestBadgePermission,
          defaultPresentAlert: defaultPresentAlert,
          defaultPresentSound: defaultPresentSound,
          defaultPresentBadge: defaultPresentBadge,
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // final MacOSInitializationSettings _settingMacOS =
    //     MacOSInitializationSettings(
    //       requestAlertPermission: requestAlertPermission,
    //       requestSoundPermission: requestSoundPermission,
    //       requestBadgePermission: requestBadgePermission,
    //       defaultPresentAlert: defaultPresentAlert,
    //       defaultPresentSound: defaultPresentSound,
    //       defaultPresentBadge: defaultPresentBadge);

    final InitializationSettings _setting =
        InitializationSettings(
          // macOS: _settingMacOS,
          android: _settingAndroid,
          iOS: _settingIOS);

    return _notifyPlugin
      .initialize(
        _setting,
        onSelectNotification: onSelectNotification)
      .then(
        (value) => value!
          ? _LocalNotifyService._(_notifyPlugin)
          : null);
  }

  final FlutterLocalNotificationsPlugin _plugin;
  late final NotificationDetails _details;

  NotificationDetails getNotificationDetails({
    String? channelId,
    String? channelName,
    String? channelDescription,
    // Android
    String? icon,
    bool? channelShowBadge,
    Importance? importance,
    Priority? priority,
    bool? playSound,
    AndroidNotificationSound? androidSound,
    bool? enableVibration,
    bool? enableLights,
    Int64List? vibrationPattern,
    StyleInformation? styleInformation,
    String? groupKey,
    bool? setAsGroupSummary,
    GroupAlertBehavior? groupAlertBehavior,
    bool? autoCancel,
    bool? ongoing,
    Color? color,
    AndroidBitmap? largeIcon,
    bool? onlyAlertOnce,
    bool? showWhen,
    int? when,
    bool? usesChronometer,
    bool? showProgress,
    int? maxProgress,
    int? progress,
    bool? indeterminate,
    Color? ledColor,
    int? ledOnMs,
    int? ledOffMs,
    String? ticker,
    AndroidNotificationChannelAction? channelAction,
    NotificationVisibility? visibility,
    int? timeoutAfter,
    String? category,
    bool? fullScreenIntent,
    String? shortcutId,
    Int32List? additionalFlags,
    String? subText,
    String? tag,
    // iOS
    bool? presentAlert,
    bool? presentSound,
    bool? presentBadge,
    String? iosSound,
    int? badgeNumber,
    List<IOSNotificationAttachment>? attachments,
    String? subtitle,
    String? threadIdentifier,
    // MacOS
    // List<MacOSNotificationAttachment>? attachmentsMacOS,
  }) {
    final AndroidNotificationDetails _specificAndroid =
        AndroidNotificationDetails(
          channelId ?? _kChannelId,
          channelName ?? _kChannelName,
          channelDescription ?? _kChannelDescription,
          icon: icon,
          importance: importance ?? Importance.defaultImportance,
          priority: priority ?? Priority.defaultPriority,
          styleInformation: styleInformation,
          playSound: playSound ?? true,
          sound: androidSound,
          enableVibration: enableVibration ?? true,
          vibrationPattern: vibrationPattern,
          groupKey: groupKey,
          setAsGroupSummary: setAsGroupSummary ?? false,
          groupAlertBehavior: groupAlertBehavior ?? GroupAlertBehavior.all,
          autoCancel: autoCancel ?? true,
          ongoing: ongoing ?? false,
          color: color,
          largeIcon: largeIcon,
          onlyAlertOnce: onlyAlertOnce ?? false,
          showWhen: showWhen ?? true,
          when: when,
          usesChronometer: usesChronometer ?? false,
          channelShowBadge: channelShowBadge ?? true,
          showProgress: showProgress ?? false,
          maxProgress: maxProgress ?? 0,
          progress: progress ?? 0,
          indeterminate: indeterminate ?? false,
          channelAction: channelAction
            ?? AndroidNotificationChannelAction.createIfNotExists,
          enableLights: enableLights ?? false,
          ledColor: ledColor,
          ledOnMs: ledOnMs,
          ledOffMs: ledOffMs,
          ticker: ticker,
          visibility: visibility,
          timeoutAfter: timeoutAfter,
          category: category,
          fullScreenIntent: fullScreenIntent ?? false,
          shortcutId: shortcutId,
          additionalFlags: additionalFlags,
          subText: subText,
          tag: tag);
    final IOSNotificationDetails _specificIOS =
        IOSNotificationDetails(
          presentAlert: presentAlert,
          presentBadge: presentBadge,
          presentSound: presentSound,
          sound: iosSound,
          badgeNumber: badgeNumber,
          attachments: attachments,
          subtitle: subtitle,
          threadIdentifier: threadIdentifier ?? _kThreadIdentifier);
    // final MacOSNotificationDetails _specificMacOS =
    //     MacOSNotificationDetails(
    //       presentAlert: presentAlert,
    //       presentBadge: presentBadge,
    //       presentSound: presentSound,
    //       sound: iosSound,
    //       badgeNumber: badgeNumber,
    //       attachments: attachmentsMacOS,
    //       subtitle: subtitle,
    //       threadIdentifier: threadIdentifier ?? _kThreadIdentifier);

    return NotificationDetails(
      // macOS: _specificMacOS,
      android: _specificAndroid,
      iOS: _specificIOS);
  }

  Future<void> show({
    required int id,
    String? title,
    String? body,
    NotificationDetails? details,
    String? payload,
  }) =>
      _plugin.show(
        id,
        title,
        body,
        details ?? _details,
        payload: payload);

  Future<void> cancel({ int? id, String? tag }) async {
    if ( id == null ) {
      await _plugin.cancelAll();
    } else {
      await _plugin.cancel(id, tag: tag);
    }
  }
}