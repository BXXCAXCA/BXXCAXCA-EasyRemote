abstract class SyncService {
  Future<void> pull();

  Future<void> push();

  Future<DateTime?> lastSyncTime();
}

class PlaceholderSyncService implements SyncService {
  DateTime? _lastSync;

  @override
  Future<void> pull() async {
    _lastSync = DateTime.now();
  }

  @override
  Future<void> push() async {
    _lastSync = DateTime.now();
  }

  @override
  Future<DateTime?> lastSyncTime() async {
    return _lastSync;
  }
}
