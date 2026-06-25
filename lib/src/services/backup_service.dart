import 'dart:convert';
import '../models/app_settings.dart';
import '../models/backup_bundle.dart';
import '../models/integration_adapter.dart';
import '../models/managed_device.dart';
import 'adapter_metadata_service.dart';
import 'import_export_service.dart';

class BackupService {
  String createBackup({
    required List<ManagedDevice> devices,
    required AppSettings settings,
    required List<IntegrationAdapter> adapters,
  }) {
    final bundle = BackupBundle(
      schemaVersion: 1,
      createdAtIso: DateTime.now().toIso8601String(),
      devicesJson: ImportExportService().exportDevices(devices),
      settingsJson: const JsonEncoder.withIndent('  ').convert(settings.toJson()),
      adapterMetadataJson: AdapterMetadataService().exportAdapters(adapters),
    );

    return const JsonEncoder.withIndent('  ').convert(bundle.toJson());
  }
}
