import '../models/vault_record.dart';
import 'vault_repository.dart';

class InMemoryVaultRepository implements VaultRepository {
  final Map<String, VaultRecord> _records = {};
  @override
  Future<List<VaultRecord>> loadRecords() async => _records.values.toList();
  @override
  Future<void> saveRecord(VaultRecord record) async => _records[record.id] = record;
  @override
  Future<void> deleteRecord(String id) async => _records.remove(id);
}
