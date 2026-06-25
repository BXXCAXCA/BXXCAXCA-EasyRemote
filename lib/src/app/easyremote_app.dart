import 'package:flutter/material.dart';
import '../features/navigation/root_shell.dart';
import '../repositories/in_memory_inventory_repository.dart';
import '../repositories/in_memory_settings_repository.dart';
import '../repositories/in_memory_activity_history_repository.dart';
import '../repositories/in_memory_vault_repository.dart';
import '../state/activity_history_controller.dart';
import '../state/adapter_registry_controller.dart';
import '../state/inventory_controller.dart';
import '../state/settings_controller.dart';
import '../state/sync_controller.dart';
import '../state/vault_controller.dart';

class EasyRemoteApp extends StatefulWidget {
  const EasyRemoteApp({super.key});

  @override
  State<EasyRemoteApp> createState() => _EasyRemoteAppState();
}

class _EasyRemoteAppState extends State<EasyRemoteApp> {
  late final InventoryController inventoryController;
  late final SettingsController settingsController;
  late final AdapterRegistryController adapterRegistryController;
  late final ActivityHistoryController activityHistoryController;
  late final VaultController vaultController;
  late final SyncController syncController;

  @override
  void initState() {
    super.initState();
    inventoryController = InventoryController(repository: InMemoryInventoryRepository.seeded())..load();
    settingsController = SettingsController(repository: InMemorySettingsRepository())..load();
    adapterRegistryController = AdapterRegistryController()..load();
    activityHistoryController = ActivityHistoryController(repository: InMemoryActivityHistoryRepository())..load();
    vaultController = VaultController(repository: InMemoryVaultRepository());
    syncController = SyncController();
  }

  @override
  void dispose() {
    inventoryController.dispose();
    settingsController.dispose();
    adapterRegistryController.dispose();
    activityHistoryController.dispose();
    vaultController.dispose();
    syncController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyRemote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F6BFF)),
        useMaterial3: true,
      ),
      home: RootShell(
        inventoryController: inventoryController,
        settingsController: settingsController,
        adapterRegistryController: adapterRegistryController,
        activityHistoryController: activityHistoryController,
        vaultController: vaultController,
        syncController: syncController,
      ),
    );
  }
}
