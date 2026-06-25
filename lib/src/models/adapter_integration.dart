enum AdapterIntegrationMode {
  metadataOnly('metadataOnly'), externalFirst('externalFirst'), embeddedCandidate('embeddedCandidate'), selfHostedConfig('selfHostedConfig'), researchOnly('researchOnly');
  const AdapterIntegrationMode(this.id);
  final String id;
  String get label => id;
}
enum AdapterRiskLevel {
  low('low'), medium('medium'), high('high'), reviewRequired('reviewRequired');
  const AdapterRiskLevel(this.id);
  final String id;
  String get label => id;
}
