import 'package:flutter/material.dart';
import '../../state/activity_history_controller.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.controller});
  final ActivityHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          actions: [IconButton(tooltip: 'Clear', onPressed: controller.clear, icon: const Icon(Icons.delete_outline))],
        ),
        body: controller.events.isEmpty
            ? const Center(child: Text('No local activity yet'))
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.events.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final event = controller.events[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.event_note_outlined),
                      title: Text(event.title),
                      subtitle: Text('${event.description}\n${event.timestampIso}'),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
