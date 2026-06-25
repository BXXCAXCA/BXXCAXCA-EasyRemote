import 'adapter_integration.dart';

class IntegrationAdapter {
  const IntegrationAdapter({
    required this.id,
    required this.name,
    required this.category,
    required this.mode,
    required this.riskLevel,
    required this.enabled,
    required this.summary,
    required this.capabilities,
    required this.guardrails,
  });
  final String id;
  final String name;
  final String category;
  final AdapterIntegrationMode mode;
  final AdapterRiskLevel riskLevel;
  final bool enabled;
  final String summary;
  final List<String> capabilities;
  final List<String> guardrails;
  IntegrationAdapter copyWith({bool? enabled}) => IntegrationAdapter(
    id: id, name: name, category: category, mode: mode, riskLevel: riskLevel,
    enabled: enabled ?? this.enabled, summary: summary, capabilities: capabilities, guardrails: guardrails,
  );
  Map<String, Object?> toJson() => {
    'id': id, 'name': name, 'category': category, 'mode': mode.id, 'riskLevel': riskLevel.id,
    'enabled': enabled, 'summary': summary, 'capabilities': capabilities, 'guardrails': guardrails,
  };
}
