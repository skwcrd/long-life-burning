import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  group('initialize()', () {
    setUpAll(() async {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    });
    testWidgets('can initialise', (tester) async {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      const IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings();
      const InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS);
      final bool? initialised = await flutterLocalNotificationsPlugin
          .initialize(initializationSettings);
      expect(initialised, isTrue);
    });
  });

  group('resolvePlatformSpecificImplementation()', () {
    setUpAll(() async {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      const IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings();
      const InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    });

    if ( Platform.isIOS ) {
      testWidgets('Can resolve iOS plugin implementation when running on iOS',
          (tester) async {
        expect(
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    IOSFlutterLocalNotificationsPlugin>(),
            isA<IOSFlutterLocalNotificationsPlugin>());
      });
    }

    if ( Platform.isAndroid ) {
      testWidgets(
          'Can resolve Android plugin implementation when running on Android',
          (tester) async {
        expect(
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>(),
            isA<AndroidFlutterLocalNotificationsPlugin>());
      });
    }

    if ( Platform.isIOS ) {
      testWidgets(
          'Returns null trying to resolve Android plugin implementation when '
          'running on iOS', (tester) async {
        expect(
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>(),
            isNull);
      });
    }

    if ( Platform.isAndroid ) {
      testWidgets(
          'Returns null trying to resolve iOS plugin implementation when '
          'running on Android', (tester) async {
        expect(
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    IOSFlutterLocalNotificationsPlugin>(),
            isNull);
      });
    }

    testWidgets('Throws argument error requesting base class type',
        (tester) async {
      expect(
          () => flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation(),
          throwsArgumentError);
    });
  });
}