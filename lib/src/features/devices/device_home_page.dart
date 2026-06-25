import 'package:flutter/material.dart';

import '../../models/connection_protocol.dart';
import '../../models/managed_device.dart';
import '../../models/route_endpoint.dart';
import '../../services/mock_inventory_service.dart';
import 'widgets/device_card.dart';

class DeviceHomePage extends StatefulWidget {
  const DeviceHomePage({super.key});

  @override
  State<DeviceHomePage> createState() => _DeviceHomePageState();
}

class _DeviceHomePageState extends State<DeviceHomePage> {
  final _inventory = MockInventoryService();
  late final List<ManagedDevice> _devices = _inventory.loadDemoDevices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyRemote'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: 'Settings',
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 800;
          return Row(
            children: [
              if (wide) const _SideNav(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const _SearchHeader(),
                    const SizedBox(height: 16),
                    ..._devices.map(
                      (device) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: DeviceCard(
                          device: device,
                          onProtocolSelected: _handleProtocol,
                          onRouteSelected: _handleRoute,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add device'),
      ),
      bottomNavigationBar: MediaQuery.sizeOf(context).width < 800
          ? NavigationBar(
              selectedIndex: 0,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.devices_other_outlined),
                  label: 'Devices',
                ),
                NavigationDestination(
                  icon: Icon(Icons.hub_outlined),
                  label: 'Adapters',
                ),
                NavigationDestination(
                  icon: Icon(Icons.folder_outlined),
                  label: 'Files',
                ),
                NavigationDestination(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
              ],
            )
          : null,
    );
  }

  void _handleProtocol(ManagedDevice device, ConnectionProtocol protocol) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Protocol placeholder: ${device.name} / ${protocol.label}'),
      ),
    );
  }

  void _handleRoute(ManagedDevice device, RouteEndpoint route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected route: ${device.name} / ${route.displayName}'),
      ),
    );
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search authorized devices',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class _SideNav extends StatelessWidget {
  const _SideNav();

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: 0,
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.devices_other_outlined),
          label: Text('Devices'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.hub_outlined),
          label: Text('Adapters'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.folder_outlined),
          label: Text('Files'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.history),
          label: Text('History'),
        ),
      ],
    );
  }
}
