import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/models.dart' as models;
import 'package:easyremote/src/services/services.dart' as services;

void main() {
  test('model barrel exports core models', () {
    expect(models.AppSettings.defaults().requireEntryConfirmation, isTrue);
    expect(models.KeyDerivationParams.recommendedPlaceholder().algorithm, isNotEmpty);
  });

  test('service barrel exports core services', () {
    expect(services.CapabilityToggleService().list(), isNotEmpty);
    expect(services.CryptoAdapterRegistry().availableAdapters(), isNotEmpty);
  });
}
