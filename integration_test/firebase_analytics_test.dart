import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('Android-only functionality', (tester) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await FirebaseAnalytics().android!.setSessionTimeoutDuration(1000);
    } else {
      expect(FirebaseAnalytics().android, isNull);
    }
  }, skip: kIsWeb);

  testWidgets('logging', (tester) async {
    expect(FirebaseAnalytics().setAnalyticsCollectionEnabled(true), completes);
    expect(
        FirebaseAnalytics().setCurrentScreen(screenName: 'testing'), completes);
    expect(FirebaseAnalytics().logEvent(name: 'testing'), completes);
    expect(
        FirebaseAnalytics().logEvent(
          name: 'view_item_list',
          parameters: {
            'item_list_id': 'Test',
            'items': [
              {
                'item_id': '1',
                'item_name': 'Item 1',
              },
              {
                'item_id': 2,
                'item_name': 'Item 2',
                'details': {
                  'detail_1': 1,
                  'detail_2': '2',
                },
              },
            ],
          },
        ),
        completes);

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      expect(
        FirebaseAnalytics().logEvent(
          name: 'test_event',
          parameters: {
            'ids': [1, 2, 3, 4, 5],
          },
        ),
        throwsA(isA<PlatformException>()),
      );
    }
  });
}