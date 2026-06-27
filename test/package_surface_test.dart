import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/models.dart' as models;
import 'package:easyremote/src/repositories/repositories.dart' as repositories;
import 'package:easyremote/src/services/services.dart' as services;
import 'package:easyremote/src/state/state.dart' as state;

void main() {
  test('package surface imports selected types', () {
    expect(models.AppSettings.defaults().webDavEnabled, isFalse);
    expect(repositories.InMemorySettingsRepository, isNotNull);
    expect(services.CapabilityToggleService().list(), isNotEmpty);
    expect(state.SettingsController, isNotNull);
  });
}
