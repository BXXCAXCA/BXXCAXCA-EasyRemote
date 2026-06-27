import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/connection_protocol.dart';
import 'package:easyremote/src/models/device_kind.dart';
import 'package:easyremote/src/models/managed_device.dart';
import 'package:easyremote/src/repositories/in_memory_inventory_repository.dart';
import 'package:easyremote/src/state/inventory_controller.dart';

void main() {
  test('inventory controller loads and mutates devices', () async {
    final controller = InventoryController(repository: InMemoryInventoryRepository());
    const device = ManagedDevice(
      id: 'd1',
      name: 'Demo',
      group: 'Lab',
      kind: DeviceKind.generic,
      routes: [],
      protocols: [ConnectionProtocol.files],
    );

    await controller.load();
    expect(controller.devices, isEmpty);

    await controller.addDevice(device);
    expect(controller.devices, hasLength(1));

    await controller.toggleFavorite(device.id);
    expect(controller.devices.first.favorite, isTrue);

    await controller.deleteDevice(device.id);
    expect(controller.devices, isEmpty);
  });
}
