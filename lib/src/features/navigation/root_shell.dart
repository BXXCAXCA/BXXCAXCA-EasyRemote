import 'package:flutter/material.dart';
import '../../state/activity_history_controller.dart';
import '../../state/adapter_registry_controller.dart';
import '../../state/inventory_controller.dart';
import '../../state/settings_controller.dart';
import '../../state/sync_controller.dart';
import '../../state/vault_controller.dart';
import '../adapters/adapter_registry_page.dart';
import '../backup/backup_restore_page.dart';
import '../devices/device_home_page.dart';
import '../history/history_page.dart';
import '../routes/route_planner_page.dart';
import '../settings/settings_page.dart';
import '../sync/sync_page.dart';

class RootShell extends StatefulWidget {
  const RootShell({
    super.key,
    required this.inventoryController,
    required this.settingsController,
    required this.adapterRegistryController,
    required this.activityHistoryController,
    required this.vaultController,
    required this.syncController,
  });

  final InventoryController inventoryController;
  final SettingsController settingsController;
  final AdapterRegistryController adapterRegistryController;
  final ActivityHistoryController activityHistoryController;
  final VaultController vaultController;
  final SyncController syncController;

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      DeviceHomePage(
        inventoryController: widget.inventoryController,
        settingsController: widget.settingsController,
        activityHistoryController: widget.activityHistoryController,
      ),
      AdapterRegistryPage(controller: widget.adapterRegistryController),
      RoutePlannerPage(inventoryController: widget.inventoryController),
      SyncPage(
        settingsController: widget.settingsController,
        syncController: widget.syncController,
      ),
      BackupRestorePage(
        inventoryController: widget.inventoryController,
        settingsController: widget.settingsController,
        adapterRegistryController: widget.adapterRegistryController,
      ),
      HistoryPage(controller: widget.activityHistoryController),
      SettingsPage(
        controller: widget.settingsController,
        vaultController: widget.vaultController,
      ),
    ];

    const items = [
      _NavItem(Icons.devices_other_outlined, Icons.devices_other, 'Devices'),
      _NavItem(Icons.extension_outlined, Icons.extension, 'Adapters'),
      _NavItem(Icons.route_outlined, Icons.route, 'Routes'),
      _NavItem(Icons.sync_outlined, Icons.sync, 'Sync'),
      _NavItem(Icons.archive_outlined, Icons.archive, 'Backup'),
      _NavItem(Icons.history, Icons.history, 'History'),
      _NavItem(Icons.settings_outlined, Icons.settings, 'Settings'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1020) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: (index) => setState(() => selectedIndex = index),
                  destinations: items.map((item) => NavigationRailDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.selectedIcon),
                    label: Text(item.label),
                  )).toList(),
                ),
                const VerticalDivider(width: 1),
                Expanded(child: pages[selectedIndex]),
              ],
            ),
          );
        }

        return Scaffold(
          body: pages[selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => setState(() => selectedIndex = index),
            destinations: items.map((item) => NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: item.label,
            )).toList(),
          ),
        );
      },
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.selectedIcon, this.label);
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
