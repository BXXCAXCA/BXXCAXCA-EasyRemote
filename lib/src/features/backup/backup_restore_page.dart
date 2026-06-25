import 'package:flutter/material.dart';
import '../../services/backup_service.dart';
import '../../state/adapter_registry_controller.dart';
import '../../state/inventory_controller.dart';
import '../../state/settings_controller.dart';

class BackupRestorePage extends StatelessWidget {
  const BackupRestorePage({
    super.key,
    required this.inventoryController,
    required this.settingsController,
    required this.adapterRegistryController,
  });

  final InventoryController inventoryController;
  final SettingsController settingsController;
  final AdapterRegistryController adapterRegistryController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Backup / restore scaffold'),
              subtitle: Text('This exports metadata only. Secrets are excluded.'),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              final backup = BackupService().createBackup(
                devices: inventoryController.devices,
                settings: settingsController.settings,
                adapters: adapterRegistryController.allAdapters,
              );
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Backup preview'),
                  content: SizedBox(width: 560, child: SingleChildScrollView(child: SelectableText(backup))),
                  actions: [TextButton(onPressed: Navigator.of(context).pop, child: const Text('Close'))],
                ),
              );
            },
            icon: const Icon(Icons.ios_share_outlined),
            label: const Text('Create backup preview'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.restore_outlined),
            label: const Text('Restore UI planned'),
          ),
        ],
      ),
    );
  }
}
