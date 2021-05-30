part of service.database;

class _CloudDBService {
  _CloudDBService._()
    : _db = FirebaseFirestore.instance;

  final FirebaseFirestore _db;
}