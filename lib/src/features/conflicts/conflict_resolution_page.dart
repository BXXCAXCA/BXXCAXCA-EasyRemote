import 'package:flutter/material.dart';
import '../../models/sync_conflict.dart';
import '../../services/sync_conflict_detector.dart';

class ConflictResolutionPage extends StatelessWidget {
  ConflictResolutionPage({super.key});

  final conflicts = SyncConflictDetector().compare(
    localHashes: const {
      'devices.json': 'local-a',
      'settings.json': 'same',
    },
    remoteHashes: const {
      'devices.json': 'remote-a',
      'settings.json': 'same',
      'manifest.json': 'remote-b',
    },
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Conflicts')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Card(
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Conflict resolution scaffold'),
                subtitle: Text('Phase 9 shows decisions only. No sync write is executed.'),
              ),
            ),
            ...conflicts.map(
              (conflict) => Card(
                child: ListTile(
                  leading: Icon(
                    conflict.needsUserDecision
                        ? Icons.report_problem_outlined
                        : Icons.compare_arrows_outlined,
                  ),
                  title: Text(conflict.path),
                  subtitle: Text(
                    '${conflict.type.name} · local=${conflict.localHash ?? '-'} · remote=${conflict.remoteHash ?? '-'}',
                  ),
                  trailing: conflict.type == SyncConflictType.bothChanged
                      ? const Chip(label: Text('Review'))
                      : null,
                ),
              ),
            ),
          ],
        ),
      );
}
