import 'package:flutter/material.dart';
import '../../services/capability_toggle_service.dart';
import '../../services/project_review_service.dart';
import '../../state/settings_controller.dart';

class ProjectReviewPage extends StatelessWidget {
  const ProjectReviewPage({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final checks = ProjectReviewService().run(settingsController.settings);
    final toggles = CapabilityToggleService().list();
    return Scaffold(
      appBar: AppBar(title: const Text('Project Review')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.fact_check_outlined),
              title: Text('Project review'),
              subtitle: Text('Local checklist and capability overview.'),
            ),
          ),
          const SizedBox(height: 12),
          Text('Checks', style: Theme.of(context).textTheme.titleMedium),
          ...checks.map((item) => Card(
            child: ListTile(
              leading: Icon(item.ok ? Icons.check_circle_outline : Icons.info_outline),
              title: Text(item.title),
              subtitle: Text(item.detail),
            ),
          )),
          const SizedBox(height: 12),
          Text('Capabilities', style: Theme.of(context).textTheme.titleMedium),
          ...toggles.map((item) => Card(
            child: ListTile(
              leading: Icon(item.enabled ? Icons.toggle_on_outlined : Icons.toggle_off_outlined),
              title: Text(item.label),
              subtitle: Text(item.notes),
            ),
          )),
        ],
      ),
    );
  }
}
