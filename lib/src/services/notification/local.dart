part of service.notification;

class _LocalNotifyService {
  _LocalNotifyService._(this._plugin, this._specifics);

  static Future<_LocalNotifyService?> _init({
    String? channelId,
    String? channelName,
    String? channelDescription,
    SelectNotificationCallback? onSelectNotification,
    DidReceiveLocalNotificationCallback? onDidReceiveLocalNotification,
  }) {
    final _notifyPlugin = FlutterLocalNotificationsPlugin();

    // Initialise the plugin. app_icon needs to be a added as
    // a drawable resource to the Android head project
    const AndroidInitializationSettings _settingAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings _settingIOS =
        IOSInitializationSettings(
          // requestAlertPermission: true,
          // requestSoundPermission: true,
          // requestBadgePermission: true,
          // defaultPresentAlert: true,
          // defaultPresentSound: true,
          // defaultPresentBadge: true,
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // const MacOSInitializationSettings _settingMacOS =
    //     MacOSInitializationSettings();

    final InitializationSettings _setting =
        InitializationSettings(
          // macOS: _settingMacOS,
          android: _settingAndroid,
          iOS: _settingIOS);

    final AndroidNotificationDetails _specificAndroid =
        AndroidNotificationDetails(
          channelId ?? _kChannelId,
          channelName ?? _kChannelName,
          channelDescription ?? _kChannelDescription,
          // icon: ,
          importance: Importance.max,
          // importance: Importance.defaultImportance,
          priority: Priority.high,
          // priority: Priority.defaultPriority,
          // styleInformation: ,
          // playSound: true,
          // sound: ,
          // enableVibration: true,
          // vibrationPattern: ,
          // groupKey: ,
          // setAsGroupSummary: false,
          // groupAlertBehavior: GroupAlertBehavior.all,
          // autoCancel: true,
          // ongoing: false,
          // color: ,
          // largeIcon: ,
          // onlyAlertOnce: false,
          showWhen: false,
          // showWhen: true,
          // when: ,
          // usesChronometer: false,
          // channelShowBadge: true,
          // showProgress: false,
          // maxProgress: 0,
          // progress: 0,
          // indeterminate: false,
          // channelAction: AndroidNotificationChannelAction.createIfNotExists,
          // enableLights: false,
          // ledColor: ,
          // ledOnMs: ,
          // ledOffMs: ,
          // ticker: ,
          // visibility: ,
          // timeoutAfter: ,
          // category: ,
          // fullScreenIntent: false,
          // shortcutId: ,
          // additionalFlags: ,
          // subText: ,
          // tag: ,
        );
    const IOSNotificationDetails _specificIOS =
        IOSNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          // sound: '',
          // badgeNumber: 0,
          // attachments: [],
          // subtitle: '',
          threadIdentifier: _kThreadIdentifier);
    // const MacOSNotificationDetails _specificMacOS =
    //     MacOSNotificationDetails(
    //       presentAlert: true,
    //       presentBadge: true,
    //       presentSound: true,
    //       sound: '',
    //       badgeNumber: 0,
    //       attachments: [],
    //       subtitle: '',
    //       threadIdentifier: _kThreadIdentifier);

    final NotificationDetails _notifySpecific =
        NotificationDetails(
          // macOS: _specificMacOS,
          android: _specificAndroid,
          iOS: _specificIOS);

    return _notifyPlugin
      .initialize(
        _setting,
        onSelectNotification: onSelectNotification)
      .then(
        (value) => value!
          ? _LocalNotifyService._(_notifyPlugin, _notifySpecific)
          : null);
  }

  final FlutterLocalNotificationsPlugin _plugin;
  final NotificationDetails _specifics;

  Future<void> show(
    int id,
    String? title,
    String? body,
    NotificationDetails? details, {
    String? payload,
  }) =>
      _plugin.show(
        id,
        title,
        body,
        details ?? _specifics,
        payload: payload);
}