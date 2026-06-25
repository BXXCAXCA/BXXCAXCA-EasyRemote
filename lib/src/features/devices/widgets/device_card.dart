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
  });

  final ManagedDevice device;
  final void Function(ManagedDevice device, ConnectionProtocol protocol)
      onProtocolSelected;
  final void Function(ManagedDevice device, RouteEndpoint route) onRouteSelected;

  @override
  Widget build(BuildContext context) {
    final bestRoute = device.bestRoute;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Icon(device.icon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DeviceTitle(device: device),
                ),
                _StatusChip(online: device.isOnline),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    bestRoute == null
                        ? 'No route available'
                        : 'Best route: ${bestRoute.displayName} · ${bestRoute.latencyLabel}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                if (bestRoute != null)
                  TextButton.icon(
                    onPressed: () => onRouteSelected(device, bestRoute),
                    icon: const Icon(Icons.route_outlined),
                    label: const Text('Use route'),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: device.protocols
                  .map(
                    (protocol) => FilledButton.tonalIcon(
                      onPressed: () => onProtocolSelected(device, protocol),
                      icon: Icon(protocol.icon),
                      label: Text(protocol.label),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceTitle extends StatelessWidget {
  const _DeviceTitle({required this.device});

  final ManagedDevice device;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          device.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 2),
        Text(
          device.group,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.online});

  final bool online;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        online ? Icons.check_circle_outline : Icons.cancel_outlined,
        size: 18,
      ),
      label: Text(online ? 'Online' : 'Offline'),
    );
  }
}
