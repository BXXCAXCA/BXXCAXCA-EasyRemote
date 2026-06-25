import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_settings.dart';
import 'package:easyremote/src/services/adapter_catalog_service.dart';
import 'package:easyremote/src/services/backup_service.dart';

void main() {
  test('backup service creates metadata bundle', () {
    final backup = BackupService().createBackup(
      devices: const [],
      settings: AppSettings.defaults(),
      adapters: AdapterCatalogService().loadBuiltInAdapters(),
    );
    expect(backup, contains('schemaVersion'));
    expect(backup, contains('devicesJson'));
    expect(backup, contains('adapterMetadataJson'));
  });
}
