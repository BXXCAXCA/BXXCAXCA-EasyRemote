import 'dart:convert';
import '../models/managed_device.dart';

class ImportExportService {
  String exportDevices(List<ManagedDevice> devices) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert({
      'schemaVersion': 1,
      'devices': devices.map((device) => device.toJson()).toList(),
    });
  }

  List<ManagedDevice> importDevices(String jsonText) {
    final decoded = jsonDecode(jsonText) as Map<String, Object?>;
    final devices = decoded['devices'] as List<Object?>? ?? [];
    return devices.cast<Map<String, Object?>>().map(ManagedDevice.fromJson).toList();
  }
}
