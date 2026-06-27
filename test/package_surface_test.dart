import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/models.dart' as models;
import 'package:easyremote/src/repositories/repositories.dart' as repositories;
import 'package:easyremote/src/services/services.dart' as services;

void main() {
  test('package surface imports selected values', () async {
    expect(models.AppSettings.defaults().webDavEnabled, isFalse);

    final settingsRepository = repositories.InMemorySettingsRepository();
    final settings = await settingsRepository.loadSettings();
    expect(settings.requireEntryConfirmation, isTrue);

    expect(services.CapabilityToggleService().list(), isNotEmpty);
  });
}
