import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void runGeoPointTests() {
  group('$GeoPoint', () {
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

    test('sets a $GeoPoint & returns one', () async {
      final DocumentReference<Map<String, dynamic>> doc =
          await initializeTest('geo-point');

      await doc.set(
        <String, dynamic>{
          'foo': const GeoPoint(10, -10),
        });

      final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();

      final GeoPoint geopoint = snapshot.data()!['foo'] as GeoPoint;
      expect(geopoint, isA<GeoPoint>());
      expect(geopoint.latitude, equals(10));
      expect(geopoint.longitude, equals(-10));
    });

    test('updates a $GeoPoint & returns', () async {
      final DocumentReference<Map<String, dynamic>> doc =
          await initializeTest('geo-point-update');

      await doc.set(
        <String, dynamic>{
          'foo': const GeoPoint(10, -10),
        });

      await doc.update({'foo': const GeoPoint(-10, 10)});

      final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();

      final GeoPoint geopoint = snapshot.data()!['foo'] as GeoPoint;
      expect(geopoint, isA<GeoPoint>());
      expect(geopoint.latitude, equals(-10));
      expect(geopoint.longitude, equals(10));
    });
  });
}