import 'package:flutter/material.dart';

import '../models/connection_protocol.dart';
import '../models/managed_device.dart';
import '../models/route_endpoint.dart';

class MockInventoryService {
  List<ManagedDevice> loadDemoDevices() {
    return const [
      ManagedDevice(
        id: 'device-windows-desktop',
        name: 'Windows Desktop',
        group: 'Personal',
        isOnline: true,
        icon: Icons.desktop_windows_outlined,
        routes: [
          RouteEndpoint(
            id: 'route-lan-1',
            displayName: 'LAN',
            source: 'local',
            addressLabel: '192.168.x.x',
            isAvailable: true,
            latencyMs: 4,
          ),
          RouteEndpoint(
            id: 'route-mesh-1',
            displayName: 'Mesh Network',
            source: 'adapter',
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
        icon: Icons.dns_outlined,
        routes: [
          RouteEndpoint(
            id: 'route-mesh-2',
            displayName: 'Mesh Network',
            source: 'adapter',
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
        icon: Icons.storage_outlined,
        routes: [
          RouteEndpoint(
            id: 'route-nas-1',
            displayName: 'Saved address',
            source: 'manual',
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
