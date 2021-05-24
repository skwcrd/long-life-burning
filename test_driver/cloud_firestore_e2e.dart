import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drive/drive.dart' as drive;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_collection_reference_e2e.dart';
import 'firestore_document_change_e2e.dart';
import 'firestore_document_reference_e2e.dart';
import 'firestore_field_value_e2e.dart';
import 'firestore_geo_point_e2e.dart';
import 'firestore_instance_e2e.dart';
import 'firestore_query_e2e.dart';
import 'firestore_snapshot_metadata_e2e.dart';
import 'firestore_timestamp_e2e.dart';
import 'firestore_transaction_e2e.dart';
import 'firestore_write_batch_e2e.dart';

bool kUseFirestoreEmulator = true;

void testsMain() {
  setUpAll(() async {
    await Firebase.initializeApp();

    if (kUseFirestoreEmulator) {
      final host = !kIsWeb && defaultTargetPlatform == TargetPlatform.android
          ? '10.0.2.2:8080'
          : 'localhost:8080';
      FirebaseFirestore.instance.settings =
          Settings(host: host, sslEnabled: false, persistenceEnabled: true);
    }
  });

  runInstanceTests();

  runCollectionReferenceTests();
  runDocumentChangeTests();
  runDocumentReferenceTests();

  runFieldValueTests();
  runGeoPointTests();
  runQueryTests();
  runSnapshotMetadataTests();
  runTimestampTests();

  runTransactionTests();
  runWriteBatchTests();
}

void main() => drive.main(testsMain);