import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/vault_state.dart';
import 'package:easyremote/src/repositories/in_memory_vault_repository.dart';
import 'package:easyremote/src/state/vault_controller.dart';

void main() {
  test('vault controller unlocks and stores demo records', () async {
    final controller = VaultController(repository: InMemoryVaultRepository());

    await controller.unlock('passphrase');
    expect(controller.state.status, VaultStatus.unlocked);

    await controller.addDemoRecord(label: 'Demo', kind: 'note', plainText: 'hello');
    expect(controller.records, hasLength(1));

    controller.lock();
    expect(controller.state.status, VaultStatus.locked);
  });

  test('vault controller rejects empty passphrase', () async {
    final controller = VaultController(repository: InMemoryVaultRepository());

    await controller.unlock('');
    expect(controller.state.status, VaultStatus.locked);
  });
}
