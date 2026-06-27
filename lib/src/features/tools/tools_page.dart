import 'package:flutter/material.dart';
import '../conflicts/conflict_resolution_page.dart';
import '../import_check/import_check_page.dart';
import '../work_items/work_items_page.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tools')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.rule_folder_outlined),
              title: const Text('Resolution workspace'),
              subtitle: const Text('Review planned decisions.'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ConflictResolutionPage()),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.fact_check_outlined),
              title: const Text('Import check'),
              subtitle: const Text('Validate bundle shape.'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ImportCheckPage()),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.playlist_add_check_outlined),
              title: const Text('Work items'),
              subtitle: const Text('Review planned metadata items.'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => WorkItemsPage()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
