import 'package:flutter/material.dart';
import '../../services/adapter_metadata_service.dart';
import '../../state/adapter_registry_controller.dart';

class AdapterRegistryPage extends StatelessWidget {
  const AdapterRegistryPage({super.key, required this.controller});
  final AdapterRegistryController controller;

  @override
  Widget build(BuildContext context) {
    final metadataService = AdapterMetadataService();
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Adapters'),
          actions: [
            IconButton(
              tooltip: 'Export metadata',
              onPressed: () {
                final text = metadataService.exportAdapters(controller.allAdapters);
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Adapter metadata export'),
                    content: SizedBox(width: 520, child: SingleChildScrollView(child: SelectableText(text))),
                    actions: [TextButton(onPressed: Navigator.of(context).pop, child: const Text('Close'))],
                  ),
                );
              },
              icon: const Icon(Icons.ios_share_outlined),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              onChanged: controller.setQuery,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search integration metadata',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 16),
            ...controller.adapters.map((adapter) => Card(
              child: ListTile(
                leading: const Icon(Icons.extension_outlined),
                title: Text(adapter.name),
                subtitle: Text('${adapter.category} · ${adapter.mode.label}\nRisk: ${adapter.riskLevel.label}'),
                isThreeLine: true,
                trailing: Switch(value: adapter.enabled, onChanged: (_) => controller.toggle(adapter.id)),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
