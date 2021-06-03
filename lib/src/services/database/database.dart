library service.database;

import 'package:cloud_firestore/cloud_firestore.dart'
  show FirebaseFirestore;
import 'package:get_storage/get_storage.dart';

import '../../utils/utils.dart'
  show InstanceException;

part 'cloud.dart';
part 'storage.dart';

class DatabaseService {
  DatabaseService._(this._cloud, this._storage);

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

  static Future<DatabaseService> init([ String container = 'long_burn' ]) =>
      _StorageService
        ._init(container)
        .then(
          (value) => _instance ??= DatabaseService._(
            _CloudDBService._(), value));
}