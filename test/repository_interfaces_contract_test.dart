import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/repositories/activity_history_repository.dart';
import 'package:easyremote/src/repositories/in_memory_activity_history_repository.dart';
import 'package:easyremote/src/repositories/in_memory_inventory_repository.dart';
import 'package:easyremote/src/repositories/in_memory_settings_repository.dart';
import 'package:easyremote/src/repositories/in_memory_vault_repository.dart';
import 'package:easyremote/src/repositories/inventory_repository.dart';
import 'package:easyremote/src/repositories/settings_repository.dart';
import 'package:easyremote/src/repositories/vault_repository.dart';

void main() {
  test('memory repositories implement repository interfaces', () {
    expect(InMemorySettingsRepository(), isA<SettingsRepository>());
    expect(InMemoryInventoryRepository(), isA<InventoryRepository>());
    expect(InMemoryVaultRepository(), isA<VaultRepository>());
    expect(InMemoryActivityHistoryRepository(), isA<ActivityHistoryRepository>());
  });
}
