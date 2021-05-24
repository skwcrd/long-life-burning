import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void runCollectionReferenceTests() {
  group('$CollectionReference', () {
    late FirebaseFirestore firestore;

    setUpAll(() async {
      firestore = FirebaseFirestore.instance;
    });

    Future<CollectionReference<Map<String, dynamic>>> initializeTest(String id) async {
      final CollectionReference<Map<String, dynamic>> collection =
          firestore.collection('flutter-tests/$id/query-tests');
      final QuerySnapshot<Map<String, dynamic>> snapshot = await collection.get();

      await Future.forEach<QueryDocumentSnapshot>(
        snapshot.docs,
        (documentSnapshot) => documentSnapshot.reference.delete());

      return collection;
    }

    test('add() adds a document', () async {
      final CollectionReference<Map<String, dynamic>> collection =
          await initializeTest('collection-reference-add');
      final rand = Random();
      final randNum = rand.nextInt(999999);
      final DocumentReference<Map<String, dynamic>> doc = await collection
        .add(<String, dynamic>{
          'value': randNum,
        });
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();

      expect(
        randNum,
        equals(snapshot.data()!['value']));
    });

    test('snapshots() can be reused', () async {
      final foo = await initializeTest('foo');

      final snapshot = foo.snapshots();
      final snapshot2 = foo.snapshots();

      expect(
        await snapshot.first,
        isA<QuerySnapshot<Map<String, dynamic>>>()
          .having(
            (e) => e.docs, 'docs', <dynamic>[]),
      );
      expect(
        await snapshot2.first,
        isA<QuerySnapshot<Map<String, dynamic>>>()
          .having(
            (e) => e.docs, 'docs', <dynamic>[]),
      );

      await foo.add(
        <String, dynamic>{'value': 42});

      expect(
        await snapshot.first,
        isA<QuerySnapshot<Map<String, dynamic>>>()
            .having((e) => e.docs, 'docs', [
          isA<QueryDocumentSnapshot>()
              .having((e) => e.data(), 'data', {'value': 42}),
        ]),
      );
      expect(
        await snapshot2.first,
        isA<QuerySnapshot<Map<String, dynamic>>>()
            .having((e) => e.docs, 'docs', [
          isA<QueryDocumentSnapshot<Map<String, dynamic>>>()
              .having((e) => e.data(), 'data', {'value': 42}),
        ]),
      );
    });

    group('withConverter', () {
      test('add/snapshot', () async {
        final foo = await initializeTest('foo');
        final fooConverter = foo.withConverter<int>(
          fromFirestore: (snapshots, _) => snapshots.data()!['value'] as int,
          toFirestore: (value, _) => {'value': value},
        );

        final fooSnapshot = foo.snapshots();
        final fooConverterSnapshot = fooConverter.snapshots();

        await expectLater(
          fooSnapshot,
          emits(isA<QuerySnapshot<Map<String, dynamic>>>()
              .having((e) => e.docs, 'docs', <dynamic>[])),
        );
        await expectLater(
          fooConverterSnapshot,
          emits(
            isA<QuerySnapshot<int>>().having((e) => e.docs, 'docs', <dynamic>[]),
          ),
        );

        final newDocument = await fooConverter.add(42);

        await expectLater(
          newDocument.get(),
          completion(
            isA<DocumentSnapshot<int>>()
              .having(
                (e) => e.data(), 'data', 42),
          ),
        );

        await expectLater(
          fooSnapshot,
          emits(
            isA<QuerySnapshot>().having((e) => e.docs, 'docs', [
              isA<QueryDocumentSnapshot>()
                .having(
                  (e) => e.data(), 'data', {'value': 42})
            ]),
          ),
        );
        await expectLater(
          fooConverterSnapshot,
          emits(
            isA<QuerySnapshot<int>>()
              .having(
                (e) => e.docs, 'docs', [
                  isA<QueryDocumentSnapshot<int>>()
                    .having(
                      (e) => e.data(), 'data', 42)
                ]),
          ),
        );

        await foo.add(
          <String, dynamic>{'value': 21});

        await expectLater(
          fooSnapshot,
          emits(
            isA<QuerySnapshot>()
              .having(
                (e) => e.docs,
                'docs',
                unorderedEquals(<dynamic>[
                  isA<QueryDocumentSnapshot<Map<String, dynamic>>>()
                    .having(
                      (e) => e.data(), 'data', {'value': 42}),
                  isA<QueryDocumentSnapshot<Map<String, dynamic>>>()
                    .having(
                      (e) => e.data(), 'data', {'value': 21})
                ])),
          ),
        );

        await expectLater(
          fooConverterSnapshot,
          emits(
            isA<QuerySnapshot<int>>()
              .having(
                (e) => e.docs,
                'docs',
                unorderedEquals(<dynamic>[
                  isA<QueryDocumentSnapshot<int>>()
                    .having(
                      (e) => e.data(), 'data', 42),
                  isA<QueryDocumentSnapshot<int>>()
                    .having(
                      (e) => e.data(), 'data', 21)
                ])),
          ),
        );
      },
      timeout: const Timeout.factor(3));
    });
  });
}