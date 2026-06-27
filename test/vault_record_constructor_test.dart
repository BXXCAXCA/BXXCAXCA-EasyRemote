import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/vault_record.dart';

void main() {
  test('vault record requires created and updated timestamps', () {
    const record = VaultRecord(
      id: 'v1',
      label: 'Demo',
      kind: 'note',
      cipherText: 'payload',
      createdAtIso: '2026-01-01T00:00:00Z',
      updatedAtIso: '2026-01-01T00:00:00Z',
    );

    expect(record.createdAtIso, isNotEmpty);
    expect(record.updatedAtIso, isNotEmpty);
  });
}
