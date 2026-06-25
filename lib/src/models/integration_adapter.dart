class IntegrationAdapter {
  const IntegrationAdapter({
    required this.id,
    required this.name,
    required this.category,
    required this.mode,
    required this.licenseRisk,
    required this.enabled,
  });

  final String id;
  final String name;
  final String category;
  final String mode;
  final String licenseRisk;
  final bool enabled;
}
