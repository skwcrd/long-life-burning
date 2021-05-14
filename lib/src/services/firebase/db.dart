part of service.firebase;

class _DatabaseService {
  _DatabaseService._()
    : _db = FirebaseFirestore.instance;

  final FirebaseFirestore _db;
}