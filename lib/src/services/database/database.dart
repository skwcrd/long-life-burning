library service.database;

import 'dart:async';

import 'package:flutter/foundation.dart'
  show kIsWeb;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../controllers/controllers.dart'
  show AuthController;
import '../../utils/utils.dart'
  show InstanceException;

part 'cloud.dart';
part 'storage.dart';

class DatabaseService {
  DatabaseService._(this._cloud, this._storage) {
    _initialized = true;
  }

  static bool _initialized = false;
  static DatabaseService? _instance;

  /// Singleton instance of DatabaseService.
  // ignore: prefer_constructors_over_static_methods
  static DatabaseService get instance {
    if ( _instance == null ) {
      throw InstanceException(
        className: 'DatabaseService',
        message: 'Please called [DatabaseService.init] before get instance this class');
    }

    return _instance!;
  }

  final _CloudDBService _cloud;
  final _StorageService? _storage;

  _CloudDBService get cloud => _cloud;
  _StorageService? get storage => _storage;

  static Future<DatabaseService> init([ String container = 'long_burn' ]) async {
    if ( !_initialized ) {
      final _cloud = await _CloudDBService._init();
      final _storage = await _StorageService._init(container);

      _instance = DatabaseService._(_cloud, _storage);
    }

    return _instance!;
  }

  Future<Map<String, dynamic>?> get userData async {
    final _auth = Get.find<AuthController>(
      tag: AuthController.tag);
    final _user = _cloud.userData(_auth.user!.uid);

    return _cloud.runTransaction(
        (transaction) => transaction.get(_user))
      .then((value) => value.data());
  }

  Stream<Map<String, dynamic>?> get userEvent async* {
    final _auth = Get.find<AuthController>(
      tag: AuthController.tag);

    final _events = await _cloud
      .userEvent(_auth.user!.uid)
      .get()
      .then((value) => value.docs);

    for ( final event in _events ) {
      final _event = await _cloud.runTransaction(
          (transaction) => transaction.get(event.reference))
        .then((value) => value.data());

      yield _event;
    }
  }

  Stream<Map<String, dynamic>?> get userGroup async* {
    final _auth = Get.find<AuthController>(
      tag: AuthController.tag);

    final _groups = await _cloud
      .userGroup(_auth.user!.uid)
      .get()
      .then((value) => value.docs);

    for ( final group in _groups ) {
      final _group = await _cloud.runTransaction(
          (transaction) => transaction.get(group.reference))
        .then((value) => value.data());

      yield _group;
    }
  }

  Stream<Map<String, dynamic>?> get userNotify async* {
    final _auth = Get.find<AuthController>(
      tag: AuthController.tag);

    final _notifications = await _cloud
      .userNotify(_auth.user!.uid)
      .get()
      .then((value) => value.docs);

    for ( final notify in _notifications ) {
      final _notify = await _cloud.runTransaction(
          (transaction) => transaction.get(notify.reference))
        .then((value) => value.data());

      yield _notify;
    }
  }
}