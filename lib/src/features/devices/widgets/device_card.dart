import 'package:flutter/material.dart';
import '../../../models/connection_protocol.dart';
import '../../../models/managed_device.dart';
import '../../../models/route_endpoint.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    super.key,
    required this.device,
    required this.onProtocolSelected,
    required this.onRouteSelected,
    required this.onToggleFavorite,
    required this.onEdit,
    required this.onDelete,
  });

  final ManagedDevice device;
  final void Function(ManagedDevice device, ConnectionProtocol protocol) onProtocolSelected;
  final void Function(ManagedDevice device, RouteEndpoint route) onRouteSelected;
  final VoidCallback onToggleFavorite;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final bestRoute = device.bestRoute;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(child: Icon(device.kind.icon)),
                const SizedBox(width: 12),
                Expanded(child: Text(device.name, style: Theme.of(context).textTheme.titleMedium)),
                IconButton(onPressed: onToggleFavorite, icon: Icon(device.favorite ? Icons.star : Icons.star_border)),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') onEdit();
                    if (value == 'delete') onDelete();
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'edit', child: Text('Edit')),
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text(bestRoute == null ? '${device.group} · No route available' : '${device.group} · Best route: ${bestRoute.displayName} · ${bestRoute.latencyLabel}')),
                if (bestRoute != null)
                  TextButton.icon(onPressed: () => onRouteSelected(device, bestRoute), icon: const Icon(Icons.route_outlined), label: const Text('Use route')),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: device.protocols.map((protocol) => FilledButton.tonalIcon(
                  onPressed: () => onProtocolSelected(device, protocol),
                  icon: Icon(protocol.icon),
                  label: Text(protocol.label),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
