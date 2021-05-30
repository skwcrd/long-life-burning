part of service.database;

class _StorageService {
  _StorageService._(this._db);

  static Future<_StorageService?> _init([
    String container = 'long_burn',
  ]) =>
      GetStorage
        .init(container)
        .then(
          (value) => value
            ? _StorageService._(GetStorage(container))
            : null);

  final GetStorage _db;

  /// Return data true if value is different of null.
  bool hasData({
    required String key,
  }) => _db.hasData(key);

  /// Read a value in storage with the given key.
  T? read<T>({
    required String key,
  }) => _db.read<T>(key);

  /// Write data on storage.
  Future<void> write<T>({
    required String key,
    required T value,
  }) => _db.write(key, value);

  /// Remove data from storage by key.
  Future<void> remove({
    required String key,
  }) => _db.remove(key);

  /// Clear all data on storage.
  Future<void> clear() =>
      _db.erase();
}