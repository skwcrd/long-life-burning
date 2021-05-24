import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void runWriteBatchTests() {
  group('$WriteBatch', () {
    late FirebaseFirestore firestore;

    setUpAll(() async {
      firestore = FirebaseFirestore.instance;
    });

    Future<CollectionReference<Map<String, dynamic>>> initializeTest(
        String id) async {
      final CollectionReference<Map<String, dynamic>> collection =
          firestore.collection('flutter-tests/$id/query-tests');
      final QuerySnapshot<Map<String, dynamic>> snapshot = await collection.get();

      await Future.forEach<QueryDocumentSnapshot>(
        snapshot.docs,
        (documentSnapshot) => documentSnapshot.reference.delete());
      return collection;
    }

    test('works with withConverter', () async {
      final CollectionReference<Map<String, dynamic>> collection =
          await initializeTest('with-converter-batch');
      WriteBatch batch = firestore.batch();

      final DocumentReference<int> doc = collection.doc('doc1')
        .withConverter(
          fromFirestore: (snapshot, options) => snapshot.data()!['value'] as int,
          toFirestore: (value, options) => {'value': value});

      var snapshot = await doc.get();

      expect(snapshot.exists, false);

      batch.set<int?>(doc, 42);

      await batch.commit();
      snapshot = await doc.get();

      expect(snapshot.exists, true);
      expect(snapshot.data(), 42);

      batch = firestore.batch()
        ..update(doc, <String, dynamic>{'value': 21});

      await batch.commit();
      snapshot = await doc.get();

      expect(snapshot.exists, true);
      expect(snapshot.data(), 21);

      batch = firestore.batch()
        ..delete(doc);

      await batch.commit();
      snapshot = await doc.get();

      expect(snapshot.exists, false);
    });

    test('performs batch operations', () async {
      final CollectionReference<Map<String, dynamic>> collection =
          await initializeTest('write-batch-ops');
      final WriteBatch batch = firestore.batch();

      final DocumentReference<Map<String, dynamic>> doc1 =
          collection.doc('doc1'); // delete
      final DocumentReference<Map<String, dynamic>> doc2 =
          collection.doc('doc2'); // set
      final DocumentReference<Map<String, dynamic>> doc3 =
          collection.doc('doc3'); // update
      final DocumentReference<Map<String, dynamic>> doc4 =
          collection.doc('doc4'); // update w/ merge
      final DocumentReference<Map<String, dynamic>> doc5 =
          collection.doc('doc5'); // update w/ mergeFields

      await Future.wait([
        doc1.set(
          <String, dynamic>{'foo': 'bar'}),
        doc2.set(
          <String, dynamic>{'foo': 'bar'}),
        doc3.set(
          <String, dynamic>{'foo': 'bar', 'bar': 'baz'}),
        doc4.set(
          <String, dynamic>{'foo': 'bar'}),
        doc5.set(
          <String, dynamic>{'foo': 'bar', 'bar': 'baz'}),
      ]);

      batch
        ..delete(doc1)
        ..set(doc2, <String, dynamic>{'bar': 'baz'})
        ..update(doc3, <String, dynamic>{'bar': 'ben'})
        ..set(doc4, <String, dynamic>{'bar': 'ben'}, SetOptions(merge: true));

      // TODO(ehesp): firebase-dart does not support mergeFields
      if (!kIsWeb) {
        batch.set(doc5, <String, dynamic>{'bar': 'ben'},
            SetOptions(mergeFields: ['bar']));
      }

      await batch.commit();

      final QuerySnapshot<Map<String, dynamic>> snapshot = await collection.get();

      expect(snapshot.docs.length, equals(4));
      expect(snapshot.docs.where((doc) => doc.id == 'doc1').isEmpty, isTrue);
      expect(
          snapshot.docs.firstWhere((doc) => doc.id == 'doc2').data(),
          equals(<String, dynamic>{
            'bar': 'baz',
          }));
      expect(
          snapshot.docs.firstWhere((doc) => doc.id == 'doc3').data(),
          equals(<String, dynamic>{
            'foo': 'bar',
            'bar': 'ben',
          }));
      expect(
          snapshot.docs.firstWhere((doc) => doc.id == 'doc4').data(),
          equals(<String, dynamic>{
            'foo': 'bar',
            'bar': 'ben',
          }));
      // ignore: todo
      // TODO(ehesp): firebase-dart does not support mergeFields
      if (!kIsWeb) {
        expect(
            snapshot.docs.firstWhere((doc) => doc.id == 'doc5').data(),
            equals(<String, dynamic>{
              'foo': 'bar',
              'bar': 'ben',
            }));
      }
    });
  });
}