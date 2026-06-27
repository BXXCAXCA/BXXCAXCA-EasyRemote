import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/connection_protocol.dart';
import 'package:easyremote/src/models/device_kind.dart';
import 'package:easyremote/src/models/managed_device.dart';
import 'package:easyremote/src/repositories/in_memory_inventory_repository.dart';

void main() {
  test('inventory repository saves and deletes devices', () async {
    final repository = InMemoryInventoryRepository();
    const device = ManagedDevice(
      id: 'device-1',
      name: 'Demo device',
      group: 'Lab',
      isOnline: true,
      kind: DeviceKind.generic,
      routes: [],
      protocols: [ConnectionProtocol.files],
    );

    await repository.saveDevice(device);
    expect(await repository.loadDevices(), hasLength(1));

    await repository.deleteDevice(device.id);
    expect(await repository.loadDevices(), isEmpty);
  });

  test('inventory repository replaceAll resets devices', () async {
    final repository = InMemoryInventoryRepository.seeded();
    expect(await repository.loadDevices(), isNotEmpty);

    await repository.replaceAll(const []);
    expect(await repository.loadDevices(), isEmpty);
  });
}
