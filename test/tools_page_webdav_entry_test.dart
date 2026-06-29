import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/features/tools/tools_page.dart';
import 'package:easyremote/src/models/app_settings.dart';
import 'package:easyremote/src/repositories/settings_repository.dart';
import 'package:easyremote/src/state/settings_controller.dart';

class _MemorySettingsRepository implements SettingsRepository {
  _MemorySettingsRepository(this.settings);

  AppSettings settings;

  @override
  Future<AppSettings> loadSettings() async => settings;

  @override
  Future<void> saveSettings(AppSettings settings) async {
    this.settings = settings;
  }
}

void main() {
  testWidgets('tools page shows WebDAV check entry', (tester) async {
    final controller = SettingsController(
      repository: _MemorySettingsRepository(AppSettings.defaults()),
    );

    await tester.pumpWidget(MaterialApp(home: ToolsPage(settingsController: controller)));

    expect(find.text('Tools'), findsOneWidget);
    expect(find.text('WebDAV check'), findsOneWidget);
    expect(find.text('Preview reachability and listing checks.'), findsOneWidget);
  });
}
