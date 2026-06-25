import 'package:flutter/foundation.dart';
import '../models/adapter_integration.dart';
import '../models/integration_adapter.dart';
import '../services/adapter_catalog_service.dart';

class AdapterRegistryController extends ChangeNotifier {
  AdapterRegistryController({AdapterCatalogService? catalogService})
      : _catalogService = catalogService ?? AdapterCatalogService();

  final AdapterCatalogService _catalogService;
  List<IntegrationAdapter> _adapters = [];
  String _query = '';

  List<IntegrationAdapter> get allAdapters => List.unmodifiable(_adapters);
  List<IntegrationAdapter> get adapters {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return List.unmodifiable(_adapters);
    return _adapters.where((a) => a.name.toLowerCase().contains(q) || a.category.toLowerCase().contains(q)).toList();
  }

  void load() {
    _adapters = _catalogService.loadBuiltInAdapters();
    notifyListeners();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void toggle(String id) {
    _adapters = [
      for (final adapter in _adapters)
        if (adapter.id == id) adapter.copyWith(enabled: !adapter.enabled) else adapter,
    ];
    notifyListeners();
  }

  List<IntegrationAdapter> byRisk(AdapterRiskLevel riskLevel) => _adapters.where((a) => a.riskLevel == riskLevel).toList();
}
