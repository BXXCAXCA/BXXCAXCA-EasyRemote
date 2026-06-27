import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/activity_event.dart';
import 'package:easyremote/src/models/vault_record.dart';
import 'package:easyremote/src/repositories/in_memory_activity_history_repository.dart';
import 'package:easyremote/src/repositories/in_memory_settings_repository.dart';
import 'package:easyremote/src/repositories/in_memory_vault_repository.dart';

void main() {
  test('memory settings repository loads defaults', () async {
    final repository = InMemorySettingsRepository();
    final settings = await repository.loadSettings();
    expect(settings.requireEntryConfirmation, isTrue);
  });

  test('memory activity repository stores events', () async {
    final repository = InMemoryActivityHistoryRepository();
    await repository.append(const ActivityEvent(
      id: 'e1',
      timestampIso: '2026-01-01T00:00:00Z',
      type: 'note',
      title: 'Created',
      description: 'Created for test.',
    ));
    expect(await repository.loadEvents(), hasLength(1));
  });

  test('memory vault repository stores records', () async {
    final repository = InMemoryVaultRepository();
    await repository.saveRecord(const VaultRecord(
      id: 'v1',
      label: 'Demo',
      kind: 'note',
      cipherText: 'text',
      createdAtIso: '2026-01-01T00:00:00Z',
      updatedAtIso: '2026-01-01T00:00:00Z',
    ));
    expect(await repository.loadRecords(), hasLength(1));
  });
}
