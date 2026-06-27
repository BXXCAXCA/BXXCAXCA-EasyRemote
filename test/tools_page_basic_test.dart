import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/features/tools/tools_page.dart';
import 'package:easyremote/src/repositories/in_memory_settings_repository.dart';
import 'package:easyremote/src/state/settings_controller.dart';

void main() {
  testWidgets('tools page shows main entries', (tester) async {
    final controller = SettingsController(repository: InMemorySettingsRepository());
    await controller.load();
    await tester.pumpWidget(MaterialApp(home: ToolsPage(settingsController: controller)));
    expect(find.text('Tools'), findsOneWidget);
    expect(find.text('Import check'), findsOneWidget);
    expect(find.text('Project review'), findsOneWidget);
  });
}
