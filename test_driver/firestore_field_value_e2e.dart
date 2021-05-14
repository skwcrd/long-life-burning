import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void runFieldValueTests() {
  group('$FieldValue', () {
    FirebaseFirestore /*?*/ firestore;

    setUpAll(() async {
      firestore = FirebaseFirestore.instance;
    });

    Future<DocumentReference<Map<String, dynamic>>> initializeTest(
        String path) async {
      final String prefixedPath = 'flutter-tests/$path';
      await firestore.doc(prefixedPath).delete();
      return firestore.doc(prefixedPath);
    }

    group('FieldValue.increment()', () {
      test('increments a number if it exists', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-increment-exists');
        await doc.set(
          <String, dynamic>{'foo': 2});
        await doc.update({'foo': FieldValue.increment(1)});
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data()['foo'], equals(3));
      });

      test('decrements a number', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-decrement-exists');
        await doc.set(
          <String, dynamic>{'foo': 2});
        await doc.update({'foo': FieldValue.increment(-1)});
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data()['foo'], equals(1));
      });

      test('sets an increment if it does not exist', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-increment-not-exists');
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.exists, isFalse);
        await doc.set(
          <String, dynamic>{
            'foo': FieldValue.increment(1),
          });
        final DocumentSnapshot<Map<String, dynamic>> snapshot2 = await doc.get();
        expect(snapshot2.data()['foo'], equals(1));
      });
    });

    group('FieldValue.serverTimestamp()', () {
      test('sets a new server time value', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-server-timestamp-new');
        await doc.set(
          <String, dynamic>{
            'foo': FieldValue.serverTimestamp(),
          });
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data()['foo'], isA<Timestamp>());
      });

      test('updates a server time value', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-server-timestamp-update');
        await doc.set(
          <String, dynamic>{
            'foo': FieldValue.serverTimestamp(),
          });
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        final Timestamp serverTime1 = snapshot.data()['foo'] as Timestamp;
        expect(serverTime1, isA<Timestamp>());
        await Future.delayed(
          const Duration(milliseconds: 100), () => null);
        await doc.update({'foo': FieldValue.serverTimestamp()});
        final DocumentSnapshot<Map<String, dynamic>> snapshot2 = await doc.get();
        final Timestamp serverTime2 = snapshot2.data()['foo'] as Timestamp;
        expect(serverTime2, isA<Timestamp>());
        expect(
            serverTime2.microsecondsSinceEpoch >
                serverTime1.microsecondsSinceEpoch,
            isTrue);
      });
    });

    group('FieldValue.delete()', () {
      test('removes a value', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-delete');
        await doc.set(
          <String, dynamic>{
            'foo': 'bar',
            'bar': 'baz',
          });
        await doc.update({'bar': FieldValue.delete()});
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data(), equals(<String, dynamic>{'foo': 'bar'}));
      });
    });

    group('FieldValue.arrayUnion()', () {
      test('updates an existing array', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-array-union-update-array');
        await doc.set(
          <String, dynamic>{
            'foo': [1, 2],
          });
        await doc.update({
          'foo': FieldValue.arrayUnion(<dynamic>[3, 4]),
        });
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data()['foo'], equals([1, 2, 3, 4]));
      });

      test('updates an array if current value is not an array', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-array-union-replace');
        await doc.set(
          <String, dynamic>{'foo': 'bar'});
        await doc.update({
          'foo': FieldValue.arrayUnion(<dynamic>[3, 4])
        });
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data()['foo'], equals([3, 4]));
      });

      test('sets an array if current value is not an array', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-array-union-replace');
        await doc.set(
          <String, dynamic>{'foo': 'bar'});
        await doc.set(
          <String, dynamic>{
            'foo': FieldValue.arrayUnion(<dynamic>[3, 4]),
          });
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data()['foo'], equals([3, 4]));
      });
    });

    group('FieldValue.arrayRemove()', () {
      test('removes items in an array', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-array-remove-existing');
        await doc.set(
          <String, dynamic>{
            'foo': [1, 2, 3, 4],
          });
        await doc.update({
          'foo': FieldValue.arrayRemove(<dynamic>[3, 4]),
        });
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data()['foo'], equals([1, 2]));
      });

      test('removes & updates an array if existing item is not an array',
          () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-array-remove-replace');
        await doc.set(
          <String, dynamic>{'foo': 'bar'});
        await doc.update({
          'foo': FieldValue.arrayUnion(<dynamic>[3, 4]),
        });
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data()['foo'], equals([3, 4]));
      });

      test('removes & sets an array if existing item is not an array',
          () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-array-remove-replace');
        await doc.set(
          <String, dynamic>{'foo': 'bar'});
        await doc.set(
          <String, dynamic>{
            'foo': FieldValue.arrayUnion(<dynamic>[3, 4]),
          });
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data()['foo'], equals([3, 4]));
      });

      // ignore: todo
      // TODO(salakar): test is currently failing on CI but unable to reproduce locally
      test('updates with nested types', () async {
        final DocumentReference<Map<String, dynamic>> doc =
            await initializeTest('field-value-nested-types');

        final DocumentReference<Map<String, dynamic>> ref =
            FirebaseFirestore.instance.doc('foo/bar');

        await doc.set(
          <String, dynamic>{
            'foo': [1],
          });
        await doc.update({
          'foo': FieldValue.arrayUnion(<dynamic>[2, ref]),
        });
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
        expect(snapshot.data()['foo'], equals([1, 2, ref]));
      },
      skip: true);
    });
  });
}
