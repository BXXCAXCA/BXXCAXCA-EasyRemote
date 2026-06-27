import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_settings.dart';
import 'package:easyremote/src/repositories/in_memory_settings_repository.dart';
import 'package:easyremote/src/state/settings_controller.dart';

void main() {
  test('settings controller loads defaults', () async {
    final repository = InMemorySettingsRepository();
    final controller = SettingsController(repository: repository);

    await controller.load();

    expect(controller.settings.requireEntryConfirmation, isTrue);
  });

  test('settings controller updates repository', () async {
    final repository = InMemorySettingsRepository();
    final controller = SettingsController(repository: repository);
    final settings = AppSettings.defaults().copyWith(requireEntryConfirmation: false);

    await controller.update(settings);
    final stored = await repository.loadSettings();

    expect(controller.settings.requireEntryConfirmation, isFalse);
    expect(stored.requireEntryConfirmation, isFalse);
  });
}
