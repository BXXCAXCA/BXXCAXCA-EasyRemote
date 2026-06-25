import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/vault_record.dart';
import 'package:easyremote/src/repositories/in_memory_vault_repository.dart';

void main() {
  test('in-memory vault repository saves records', () async {
    final repository = InMemoryVaultRepository();
    const record = VaultRecord(
      id: '1',
      label: 'Label',
      kind: 'demo',
      cipherText: 'cipher',
      createdAtIso: '2026-01-01T00:00:00.000',
      updatedAtIso: '2026-01-01T00:00:00.000',
    );
    await repository.saveRecord(record);
    final records = await repository.loadRecords();
    expect(records.single.id, '1');
  });
}
