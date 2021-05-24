import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void runTimestampTests() {
  group('$Timestamp', () {
    FirebaseFirestore? firestore;

    setUpAll(() async {
      firestore = FirebaseFirestore.instance;
    });

    Future<DocumentReference<Map<String, dynamic>>> initializeTest(
      String path,
    ) async {
      final String prefixedPath = 'flutter-tests/$path';
      await firestore!.doc(prefixedPath).delete();
      return firestore!.doc(prefixedPath);
    }

    test('sets a $Timestamp & returns one', () async {
      final DocumentReference<Map<String, dynamic>> doc =
          await initializeTest('timestamp');
      final DateTime date = DateTime.utc(3000);

      await doc.set(
        <String, dynamic>{'foo': Timestamp.fromDate(date)});

      final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
      final Timestamp timestamp = snapshot.data()!['foo'] as Timestamp;
      expect(timestamp, isA<Timestamp>());
      expect(
        timestamp.millisecondsSinceEpoch,
        equals(date.millisecondsSinceEpoch),
      );
    });

    test('updates a $Timestamp & returns', () async {
      final DocumentReference<Map<String, dynamic>> doc =
          await initializeTest('geo-point-update');
      final DateTime date = DateTime.utc(3000, 01, 02);

      await doc.set(
        <String, dynamic>{'foo': DateTime.utc(3000)});
      await doc.update({'foo': date});

      final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
      final Timestamp timestamp = snapshot.data()!['foo'] as Timestamp;
      expect(timestamp, isA<Timestamp>());
      expect(
        timestamp.millisecondsSinceEpoch,
        equals(date.millisecondsSinceEpoch),
      );
    });
  });
}