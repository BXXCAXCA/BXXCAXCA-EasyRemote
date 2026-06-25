import 'package:flutter/foundation.dart';
import '../models/managed_device.dart';
import '../repositories/inventory_repository.dart';
import '../services/import_export_service.dart';

class InventoryController extends ChangeNotifier {
  InventoryController({
    required InventoryRepository repository,
    ImportExportService? importExportService,
  })  : _repository = repository,
        _importExportService = importExportService ?? ImportExportService();

  final InventoryRepository _repository;
  final ImportExportService _importExportService;

  List<ManagedDevice> _devices = [];
  List<ManagedDevice> get devices => List.unmodifiable(_devices);

  Future<void> load() async {
    _devices = await _repository.loadDevices();
    notifyListeners();
  }

  Future<void> addDevice(ManagedDevice device) async {
    await _repository.saveDevice(device);
    await load();
  }

  Future<void> updateDevice(ManagedDevice device) async {
    await _repository.saveDevice(device);
    await load();
  }

  Future<void> deleteDevice(String id) async {
    await _repository.deleteDevice(id);
    await load();
  }

  Future<void> toggleFavorite(String id) async {
    final matches = _devices.where((item) => item.id == id);
    if (matches.isEmpty) return;
    final device = matches.first;
    await _repository.saveDevice(device.copyWith(favorite: !device.favorite));
    await load();
  }

  Future<String> exportJson() async => _importExportService.exportDevices(_devices);
}
