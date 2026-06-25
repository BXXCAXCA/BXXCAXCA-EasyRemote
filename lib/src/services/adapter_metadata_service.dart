import 'dart:convert';
import '../models/integration_adapter.dart';

class AdapterMetadataService {
  String exportAdapters(List<IntegrationAdapter> adapters) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert({
      'schemaVersion': 1,
      'adapters': adapters.map((adapter) => adapter.toJson()).toList(),
    });
  }
}
