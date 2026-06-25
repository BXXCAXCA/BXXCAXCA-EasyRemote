import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/connection_protocol.dart';
import '../../models/device_kind.dart';
import '../../models/managed_device.dart';
import '../../models/route_endpoint.dart';
import '../../models/route_source.dart';

class DeviceEditPage extends StatefulWidget {
  const DeviceEditPage({super.key, this.device});
  final ManagedDevice? device;

  @override
  State<DeviceEditPage> createState() => _DeviceEditPageState();
}

class _DeviceEditPageState extends State<DeviceEditPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController groupController;
  late DeviceKind kind;
  late bool favorite;
  late Set<ConnectionProtocol> protocols;
  late List<RouteEndpoint> routes;

  @override
  void initState() {
    super.initState();
    final device = widget.device;
    nameController = TextEditingController(text: device?.name ?? '');
    groupController = TextEditingController(text: device?.group ?? 'Personal');
    kind = device?.kind ?? DeviceKind.generic;
    favorite = device?.favorite ?? false;
    protocols = {...(device?.protocols ?? ConnectionProtocol.values)};
    routes = [...(device?.routes ?? const [])];
  }

  @override
  void dispose() {
    nameController.dispose();
    groupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.device != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit device' : 'Add device')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Device name', border: OutlineInputBorder()),
              validator: (value) => value == null || value.trim().isEmpty ? 'Device name is required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: groupController,
              decoration: const InputDecoration(labelText: 'Group', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<DeviceKind>(
              initialValue: kind,
              decoration: const InputDecoration(labelText: 'Device type', border: OutlineInputBorder()),
              items: DeviceKind.values.map((value) => DropdownMenuItem(value: value, child: Text(value.label))).toList(),
              onChanged: (value) {
                if (value != null) setState(() => kind = value);
              },
            ),
            SwitchListTile(value: favorite, onChanged: (value) => setState(() => favorite = value), title: const Text('Favorite')),
            const SizedBox(height: 12),
            Text('Available entries', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8,
              children: ConnectionProtocol.values.map((protocol) => FilterChip(
                selected: protocols.contains(protocol),
                label: Text(protocol.label),
                avatar: Icon(protocol.icon, size: 18),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      protocols.add(protocol);
                    } else {
                      protocols.remove(protocol);
                    }
                  });
                },
              )).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Text('Routes', style: Theme.of(context).textTheme.titleMedium)),
                TextButton.icon(onPressed: _addRoute, icon: const Icon(Icons.add), label: const Text('Add route')),
              ],
            ),
            ...routes.map((route) => Card(
              child: ListTile(
                leading: const Icon(Icons.route_outlined),
                title: Text(route.displayName),
                subtitle: Text('${route.sourceType.label} · ${route.addressLabel} · ${route.latencyLabel}'),
                trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => setState(() => routes.remove(route))),
              ),
            )),
            const SizedBox(height: 24),
            FilledButton.icon(onPressed: _save, icon: const Icon(Icons.save_outlined), label: const Text('Save')),
          ],
        ),
      ),
    );
  }

  void _addRoute() {
    setState(() {
      routes.add(RouteEndpoint(
        id: const Uuid().v4(),
        displayName: 'Manual route',
        source: 'manual',
        sourceType: RouteSourceType.manual,
        addressLabel: 'not configured',
        isAvailable: false,
        latencyMs: null,
      ));
    });
  }

  void _save() {
    if (!formKey.currentState!.validate()) return;
    final existing = widget.device;
    final device = ManagedDevice(
      id: existing?.id ?? const Uuid().v4(),
      name: nameController.text.trim(),
      group: groupController.text.trim().isEmpty ? 'Personal' : groupController.text.trim(),
      isOnline: existing?.isOnline ?? true,
      kind: kind,
      routes: routes,
      protocols: protocols.toList(),
      favorite: favorite,
      tags: existing?.tags ?? const [],
    );
    Navigator.of(context).pop(device);
  }
}
