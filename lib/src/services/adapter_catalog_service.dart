import '../models/adapter_integration.dart';
import '../models/integration_adapter.dart';

class AdapterCatalogService {
  List<IntegrationAdapter> loadBuiltInAdapters() => const [
    IntegrationAdapter(
      id: 'easytier',
      name: 'EasyTier',
      category: 'Mesh network metadata',
      mode: AdapterIntegrationMode.embeddedCandidate,
      riskLevel: AdapterRiskLevel.reviewRequired,
      enabled: false,
      summary: 'Open-source mesh networking candidate for deeper integration.',
      capabilities: ['Node metadata planning', 'Route source planning'],
      guardrails: ['Review upstream license before distribution'],
    ),
    IntegrationAdapter(
      id: 'tailscale',
      name: 'Tailscale',
      category: 'External mesh metadata',
      mode: AdapterIntegrationMode.externalFirst,
      riskLevel: AdapterRiskLevel.medium,
      enabled: false,
      summary: 'External-first integration candidate using user-managed setup.',
      capabilities: ['External status metadata planning'],
      guardrails: ['Respect upstream terms'],
    ),
  ];
}
