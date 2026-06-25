import 'package:flutter/material.dart';
import '../../state/settings_controller.dart';
import '../../state/sync_controller.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({
    super.key,
    required this.settingsController,
    required this.syncController,
  });

  final SettingsController settingsController;
  final SyncController syncController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([settingsController, syncController]),
      builder: (context, _) {
        final result = syncController.lastResult;
        return Scaffold(
          appBar: AppBar(title: const Text('Sync')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Card(
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Dry-run only'),
                  subtitle: Text('No network request is sent in this scaffold.'),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: syncController.running ? null : () => syncController.runDryRun(settingsController.settings),
                icon: const Icon(Icons.play_arrow_outlined),
                label: Text(syncController.running ? 'Checking...' : 'Run sync dry-run'),
              ),
              if (result != null) ...[
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    leading: Icon(result.ok ? Icons.check_circle_outline : Icons.warning_amber_outlined),
                    title: Text(result.title),
                    subtitle: Text('${result.details.join('\n')}\n${result.checkedAtIso}'),
                    isThreeLine: true,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
