import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/features/project_review/project_review_page.dart';
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
  testWidgets('project review page renders checks and capabilities', (tester) async {
    final controller = SettingsController(
      repository: _MemorySettingsRepository(AppSettings.defaults()),
    );

    await tester.pumpWidget(
      MaterialApp(home: ProjectReviewPage(settingsController: controller)),
    );

    expect(find.text('Project Review'), findsOneWidget);
    expect(find.text('Project review'), findsOneWidget);
    expect(find.text('Checks'), findsOneWidget);
    expect(find.text('Capabilities'), findsOneWidget);
  });
}
