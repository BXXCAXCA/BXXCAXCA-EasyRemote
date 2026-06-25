import '../models/connection_protocol.dart';
import '../models/device_kind.dart';
import '../models/managed_device.dart';
import '../models/route_endpoint.dart';
import '../models/route_source.dart';
import 'inventory_repository.dart';

class InMemoryInventoryRepository implements InventoryRepository {
  InMemoryInventoryRepository([List<ManagedDevice> initial = const []]) : _devices = {for (final d in initial) d.id: d};
  factory InMemoryInventoryRepository.seeded() => InMemoryInventoryRepository(const [
    ManagedDevice(
      id: 'device-windows-desktop',
      name: 'Windows Desktop',
      group: 'Personal',
      isOnline: true,
      kind: DeviceKind.windows,
      routes: [
        RouteEndpoint(
          id: 'route-lan-1',
          displayName: 'LAN',
          source: 'local',
          sourceType: RouteSourceType.local,
          addressLabel: '192.168.x.x',
          isAvailable: true,
          latencyMs: 4,
        ),
      ],
      protocols: [ConnectionProtocol.desktop, ConnectionProtocol.screen, ConnectionProtocol.files],
      favorite: true,
    ),
  ]);
  final Map<String, ManagedDevice> _devices;
  @override
  Future<List<ManagedDevice>> loadDevices() async => _devices.values.toList();
  @override
  Future<void> saveDevice(ManagedDevice device) async => _devices[device.id] = device;
  @override
  Future<void> deleteDevice(String id) async => _devices.remove(id);
  @override
  Future<void> replaceAll(List<ManagedDevice> devices) async {
    _devices..clear()..addEntries(devices.map((d) => MapEntry(d.id, d)));
  }
}
