import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void runTransactionTests() {
  group('$Transaction', () {
    /*late*/ FirebaseFirestore firestore;

    setUpAll(() async {
      firestore = FirebaseFirestore.instance;
    });

    Future<DocumentReference<Map<String, dynamic>>> initializeTest(
        String path) async {
      final String prefixedPath = 'flutter-tests/$path';
      await firestore.doc(prefixedPath).delete();
      return firestore.doc(prefixedPath);
    }

    test('works with withConverter', () async {
      final DocumentReference<Map<String, dynamic>> rawDoc =
          await initializeTest('with-converter-batch');

      final DocumentReference<int> doc = rawDoc.withConverter(
        fromFirestore: (snapshot, options) => snapshot.data()['value'] as int,
        toFirestore: (value, options) => {'value': value});

      await doc.set(42);

      expect(
        await firestore.runTransaction<int>((transaction) async {
          final snapshot = await transaction.get<int>(doc);
          return snapshot.data();
        }),
        42,
      );

      await firestore.runTransaction<void>((transaction) {
        transaction.set(doc, 21);
        return;
      });

      expect(await doc.get().then((s) => s.data()), 21);

      await firestore.runTransaction<void>((transaction) {
        transaction.update(doc, <String, dynamic>{'value': 0});
        return;
      });

      expect(await doc.get().then((s) => s.data()), 0);
    });

    test('should resolve with user value', () async {
      final int randomValue = Random().nextInt(9999);
      final int response =
          await firestore.runTransaction<int>(
            (transaction) async => randomValue);
      expect(response, equals(randomValue));
    });

    test('should abort if thrown and not continue', () async {
      final DocumentReference<Map<String, dynamic>> documentReference =
          await initializeTest('transaction-abort');

      await documentReference.set(
        <String, dynamic>{'foo': 'bar'});

      try {
        await firestore.runTransaction((transaction) async {
          transaction.set(documentReference, {
            'foo': 'baz',
          });

          // ignore: only_throw_errors
          throw 'Stop';
        });
        // ignore: dead_code
        fail('Should have thrown');
      } catch (e) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await documentReference.get();
        expect(snapshot.data()['foo'], equals('bar'));
      }
    });

    test('runs multiple transactions in parallel', () async {
      final DocumentReference<Map<String, dynamic>> doc1 =
          await initializeTest('transaction-multi-1');
      final DocumentReference<Map<String, dynamic>> doc2 =
          await initializeTest('transaction-multi-2');

      await doc1.set(
        <String, dynamic>{'test': 'value1'});
      await doc2.set(
        <String, dynamic>{'test': 'value2'});

      await Future.wait([
        firestore.runTransaction((transaction) async {
          transaction.set(doc1, {
            'test': 'value3',
          });
        }),
        firestore.runTransaction((transaction) async {
          transaction.set(doc2, {
            'test': 'value4',
          });
        }),
      ]);

      final DocumentSnapshot<Map<String, dynamic>> snapshot1 = await doc1.get();
      expect(snapshot1.data()['test'], equals('value3'));
      final DocumentSnapshot<Map<String, dynamic>> snapshot2 = await doc2.get();
      expect(snapshot2.data()['test'], equals('value4'));
    });

    test('should abort if timeout is exceeded', () async {
      await expectLater(
        firestore.runTransaction(
          (transaction) async {
            await Future.delayed(
              const Duration(seconds: 2), () => null);
          },
          timeout: const Duration(seconds: 1)),
        throwsA(
          isA<FirebaseException>()
              .having((e) => e.code, 'code', 'deadline-exceeded'),
        ),
      );
    });

    test('should throw with exception', () async {
      try {
        await firestore.runTransaction((transaction) async {
          throw StateError('foo');
        });
        // ignore: dead_code
        fail('Transaction should not have resolved');
      // ignore: avoid_catching_errors
      } on StateError catch (e) {
        expect(e.message, equals('foo'));
        return;
      } catch (e) {
        fail('Transaction threw invalid exeption');
      }
    });

    test('should throw a native error, and convert to a [FirebaseException]',
        () async {
      final DocumentReference<Map<String, dynamic>> documentReference =
          firestore.doc('not-allowed/document');

      try {
        await firestore.runTransaction((transaction) async {
          transaction.set(documentReference, {'foo': 'bar'});
        });
        fail('Transaction should not have resolved');
      } on FirebaseException catch (e) {
        expect(e.code, equals('permission-denied'));
        return;
      } catch (e) {
        fail('Transaction threw invalid exeption');
      }
    });

    group('Transaction.get()', () {
      test('should throw if get is called after a command', () async {
        final DocumentReference<Map<String, dynamic>> documentReference =
            firestore.doc('flutter-tests/foo');

        expect(
            () => firestore.runTransaction((transaction) async {
                  await transaction.get(documentReference);
                  transaction.set(documentReference, {'foo': 'bar'});
                  await transaction.get(documentReference);
                }),
            throwsAssertionError);
      });

      // ignore: todo
      // TODO(Salakar): Test seems to fail sometimes. Will look at in a future PR.
      // test('support returning any value, e.g. a [DocumentSnapshot]', () async {
      //   DocumentReference<Map<String, dynamic>> documentReference =
      //       await initializeTest('transaction-get');

      //   DocumentSnapshot<Map<String, dynamic>> snapshot =
      //       await firestore.runTransaction((Transaction transaction) async {
      //     DocumentSnapshot<Map<String, dynamic>> returned = await transaction.get(documentReference);
      //     // required:
      //     transaction.set(documentReference, {'foo': 'bar'});
      //     return returned;
      //   });

      //   expect(snapshot, isA<DocumentSnapshot>());
      //   expect(snapshot.reference.path, equals(documentReference.path));
      // }, skip: kUseFirestoreEmulator);
    });

    group('Transaction.delete()', () {
      test('should delete a document', () async {
        final DocumentReference<Map<String, dynamic>> documentReference =
            await initializeTest('transaction-delete');

        await documentReference.set(
          <String, dynamic>{'foo': 'bar'});

        await firestore.runTransaction((transaction) async {
          transaction.delete(documentReference);
        });

        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await documentReference.get();
        expect(snapshot.exists, isFalse);
      });
    });

    group('Transaction.update()', () {
      test('should update a document', () async {
        final DocumentReference<Map<String, dynamic>> documentReference =
            await initializeTest('transaction-update');

        await documentReference.set(
          <String, dynamic>{'foo': 'bar', 'bar': 1});

        await firestore.runTransaction((transaction) async {
          final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
              await transaction.get(documentReference);
          transaction.update(documentReference, <String, dynamic>{
            'bar': documentSnapshot.data()['bar'] + 1,
          });
        });

        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await documentReference.get();
        expect(snapshot.exists, isTrue);
        expect(snapshot.data()['bar'], equals(2));
        expect(snapshot.data()['foo'], equals('bar'));
      });
    });

    group('Transaction.set()', () {
      test('sets a document', () async {
        final DocumentReference<Map<String, dynamic>> documentReference =
            await initializeTest('transaction-set');

        await documentReference.set(
          <String, dynamic>{'foo': 'bar', 'bar': 1});

        await firestore.runTransaction((transaction) async {
          final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
              await transaction.get(documentReference);
          transaction.set(documentReference, <String, dynamic>{
            'bar': documentSnapshot.data()['bar'] + 1,
          });
        });

        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await documentReference.get();
        expect(snapshot.exists, isTrue);
        expect(
            snapshot.data(),
            equals(<String, dynamic>{
              'bar': 2,
            }));
      });

      test('merges a document with set', () async {
        final DocumentReference<Map<String, dynamic>> documentReference =
            await initializeTest('transaction-set-merge');

        await documentReference.set(
          <String, dynamic>{'foo': 'bar', 'bar': 1});

        await firestore.runTransaction((transaction) async {
          final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
              await transaction.get(documentReference);
          transaction.set(
            documentReference,
            <String, dynamic>{
              'bar': documentSnapshot.data()['bar'] + 1,
            },
            SetOptions(merge: true));
        });

        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await documentReference.get();
        expect(snapshot.exists, isTrue);
        expect(snapshot.data()['bar'], equals(2));
        expect(snapshot.data()['foo'], equals('bar'));
      });

      test('merges fields a document with set', () async {
        final DocumentReference<Map<String, dynamic>> documentReference =
            await initializeTest('transaction-set-merge-fields');

        await documentReference.set(
          <String, dynamic>{'foo': 'bar', 'bar': 1, 'baz': 1});

        await firestore.runTransaction((transaction) async {
          final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
              await transaction.get(documentReference);
          transaction.set(
              documentReference,
              <String, dynamic>{
                'bar': documentSnapshot.data()['bar'] + 1,
                'baz': 'ben',
              },
              SetOptions(mergeFields: ['bar']));
        });

        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await documentReference.get();
        expect(snapshot.exists, isTrue);
        expect(snapshot.data(),
            equals(<String, dynamic>{'foo': 'bar', 'bar': 2, 'baz': 1}));
      });
    });

    test('runs all commands in a single transaction', () async {
      final DocumentReference<Map<String, dynamic>> documentReference =
          await initializeTest('transaction-all');

      final DocumentReference<Map<String, dynamic>> documentReference2 =
          firestore.doc('flutter-tests/delete');

      await documentReference2.set(
        <String, dynamic>{'foo': 'bar'});
      await documentReference.set(
        <String, dynamic>{'foo': 1});

      final String result = await firestore
          .runTransaction<String>((transaction) async {
        final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await transaction.get(documentReference);

        transaction.set(documentReference, <String, dynamic>{
          'foo': documentSnapshot.data()['foo'] + 1,
        })
        ..update(documentReference, <String, dynamic>{'bar': 'baz'})
        ..delete(documentReference2);

        return 'done';
      });

      expect(result, equals('done'));

      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await documentReference.get();
      expect(snapshot.exists, isTrue);
      expect(
          snapshot.data(),
          equals(<String, dynamic>{
            'foo': 2,
            'bar': 'baz',
          }));

      final DocumentSnapshot<Map<String, dynamic>> snapshot2 =
          await documentReference2.get();
      expect(snapshot2.exists, isFalse);
    });
  },
  skip: kIsWeb);
}