import '../models/connection_protocol.dart';
import '../models/device_kind.dart';
import '../models/managed_device.dart';
import '../models/route_endpoint.dart';
import '../models/route_source.dart';

class MockInventoryService {
  List<ManagedDevice> loadDemoDevices() {
    return const [
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
          RouteEndpoint(
            id: 'route-mesh-1',
            displayName: 'Mesh Network',
            source: 'adapter',
            sourceType: RouteSourceType.mesh,
            addressLabel: '100.x.x.x',
            isAvailable: true,
            latencyMs: 36,
          ),
        ],
        protocols: [
          ConnectionProtocol.desktop,
          ConnectionProtocol.screen,
          ConnectionProtocol.files,
          ConnectionProtocol.nativeSession,
        ],
      ),
      ManagedDevice(
        id: 'device-linux-server',
        name: 'Linux Server',
        group: 'Lab',
        isOnline: true,
        kind: DeviceKind.linux,
        routes: [
          RouteEndpoint(
            id: 'route-mesh-2',
            displayName: 'Mesh Network',
            source: 'adapter',
            sourceType: RouteSourceType.mesh,
            addressLabel: '10.x.x.x',
            isAvailable: true,
            latencyMs: 48,
          ),
        ],
        protocols: [
          ConnectionProtocol.shell,
          ConnectionProtocol.files,
        ],
      ),
      ManagedDevice(
        id: 'device-nas',
        name: 'NAS',
        group: 'Home',
        isOnline: false,
        kind: DeviceKind.nas,
        routes: [
          RouteEndpoint(
            id: 'route-nas-1',
            displayName: 'Saved address',
            source: 'manual',
            sourceType: RouteSourceType.manual,
            addressLabel: 'nas.local',
            isAvailable: false,
            latencyMs: null,
          ),
        ],
        protocols: [
          ConnectionProtocol.files,
          ConnectionProtocol.shell,
        ],
      ),
    ];
  }
}
