part of service.database;

class _CloudDBService {
  _CloudDBService._(this._db);

  final FirebaseFirestore _db;

  static Future<_CloudDBService> _init() async {
    final _db = FirebaseFirestore.instance;

    if ( kIsWeb ) {
      await _db.enablePersistence();
    }

    return _CloudDBService._(_db);
  }

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  CollectionReference<Map<String, dynamic>> get events =>
      _db.collection('events');

  CollectionReference<Map<String, dynamic>> get groups =>
      _db.collection('groups');

  CollectionReference<Map<String, dynamic>> get places =>
      _db.collection('places');

  DocumentReference<Map<String, dynamic>> userData(String id) =>
      _users.doc(id);

  CollectionReference<Map<String, dynamic>> userEvent(String id) =>
      userData(id).collection('events');

  CollectionReference<Map<String, dynamic>> userGroup(String id) =>
      userData(id).collection('groups');

  CollectionReference<Map<String, dynamic>> userNotify(String id) =>
      userData(id).collection('notifications');

  Future<T> runTransaction<T>(
    TransactionHandler<T> transactionHandler, {
    Duration timeout = const Duration(seconds: 30),
  }) => _db.runTransaction(transactionHandler, timeout: timeout);
}