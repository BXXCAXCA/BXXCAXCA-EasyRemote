import 'package:flutter/material.dart';
import '../../models/sync_conflict.dart';
import '../../services/sync_queue_service.dart';

class WorkItemsPage extends StatelessWidget {
  WorkItemsPage({super.key});

  final items = SyncQueueService().buildQueue(const [
    SyncConflict(path: 'devices.json', type: SyncConflictType.localOnly, localHash: 'a', remoteHash: null),
    SyncConflict(path: 'settings.json', type: SyncConflictType.remoteOnly, localHash: null, remoteHash: 'b'),
    SyncConflict(path: 'manifest.json', type: SyncConflictType.bothChanged, localHash: 'c', remoteHash: 'd'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Work Items')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Work item preview'),
              subtitle: Text('Shows planned metadata actions for review.'),
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Card(
            child: ListTile(
              leading: const Icon(Icons.playlist_add_check_outlined),
              title: Text(item.path),
              subtitle: Text('${item.action.name} · ${item.status.name} · ${item.errorCode ?? '-'}'),
            ),
          )),
        ],
      ),
    );
  }
}
