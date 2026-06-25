import '../models/vault_record.dart';
abstract class VaultRepository {
  Future<List<VaultRecord>> loadRecords();
  Future<void> saveRecord(VaultRecord record);
  Future<void> deleteRecord(String id);
}
