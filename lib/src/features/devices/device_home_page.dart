import 'package:flutter/material.dart';
import '../../models/connection_protocol.dart';
import '../../models/managed_device.dart';
import '../../models/route_endpoint.dart';
import '../../services/confirmation_service.dart';
import '../../state/activity_history_controller.dart';
import '../../state/inventory_controller.dart';
import '../../state/settings_controller.dart';
import 'device_edit_page.dart';
import 'widgets/device_card.dart';

class DeviceHomePage extends StatefulWidget {
  const DeviceHomePage({
    super.key,
    required this.inventoryController,
    required this.settingsController,
    required this.activityHistoryController,
  });

  final InventoryController inventoryController;
  final SettingsController settingsController;
  final ActivityHistoryController activityHistoryController;

  @override
  State<DeviceHomePage> createState() => _DeviceHomePageState();
}

class _DeviceHomePageState extends State<DeviceHomePage> {
  final confirmationService = const MaterialConfirmationService();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.inventoryController,
      builder: (context, _) {
        final devices = widget.inventoryController.devices
            .where((device) => query.trim().isEmpty ||
                device.name.toLowerCase().contains(query.toLowerCase()) ||
                device.group.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('EasyRemote'),
            actions: [
              IconButton(
                tooltip: 'Refresh',
                onPressed: widget.inventoryController.load,
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                tooltip: 'Export preview',
                onPressed: _showExportPreview,
                icon: const Icon(Icons.ios_share_outlined),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                onChanged: (value) => setState(() => query = value),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search authorized devices',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 16),
              if (devices.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: Text('No devices found.')),
                  ),
                )
              else
                ...devices.map((device) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DeviceCard(
                    device: device,
                    onProtocolSelected: _handleProtocol,
                    onRouteSelected: _handleRoute,
                    onToggleFavorite: () => widget.inventoryController.toggleFavorite(device.id),
                    onEdit: () => _openEditor(device),
                    onDelete: () => _confirmDelete(device),
                  ),
                )),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openEditor(null),
            icon: const Icon(Icons.add),
            label: const Text('Add device'),
          ),
        );
      },
    );
  }

  Future<void> _openEditor(ManagedDevice? device) async {
    final result = await Navigator.of(context).push<ManagedDevice>(
      MaterialPageRoute(builder: (context) => DeviceEditPage(device: device)),
    );
    if (result == null) return;
    if (device == null) {
      await widget.inventoryController.addDevice(result);
      await widget.activityHistoryController.add(type: 'device', title: 'Device added', description: result.name, deviceId: result.id);
    } else {
      await widget.inventoryController.updateDevice(result);
      await widget.activityHistoryController.add(type: 'device', title: 'Device updated', description: result.name, deviceId: result.id);
    }
  }

  Future<void> _confirmDelete(ManagedDevice device) async {
    final confirmed = await confirmationService.confirm(
      context,
      ConfirmationRequest(
        title: 'Delete ${device.name}?',
        message: 'This removes the local device record only.',
        confirmLabel: 'Delete',
        destructive: true,
      ),
    );
    if (confirmed) {
      await widget.inventoryController.deleteDevice(device.id);
      await widget.activityHistoryController.add(type: 'device', title: 'Device deleted', description: device.name, deviceId: device.id);
    }
  }

  Future<void> _handleProtocol(ManagedDevice device, ConnectionProtocol protocol) async {
    final settings = widget.settingsController.settings;
    if (settings.requireEntryConfirmation) {
      final confirmed = await confirmationService.confirm(
        context,
        ConfirmationRequest(
          title: 'Open ${protocol.label} entry?',
          message: 'This is a placeholder confirmation for future authorized launch behavior.',
        ),
      );
      if (!confirmed) return;
    }
    await widget.activityHistoryController.add(type: 'entry', title: 'Entry placeholder confirmed', description: '${device.name} / ${protocol.label}', deviceId: device.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Entry placeholder: ${device.name} / ${protocol.label}')),
    );
  }

  void _handleRoute(ManagedDevice device, RouteEndpoint route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected route: ${device.name} / ${route.displayName}')),
    );
  }

  Future<void> _showExportPreview() async {
    final json = await widget.inventoryController.exportJson();
    if (!mounted) return;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export preview'),
        content: SizedBox(width: 520, child: SingleChildScrollView(child: SelectableText(json))),
        actions: [TextButton(onPressed: Navigator.of(context).pop, child: const Text('Close'))],
      ),
    );
  }
}
