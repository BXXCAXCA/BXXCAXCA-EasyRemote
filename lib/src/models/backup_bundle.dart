class BackupBundle {
  const BackupBundle({
    required this.schemaVersion,
    required this.createdAtIso,
    required this.devicesJson,
    required this.settingsJson,
    required this.adapterMetadataJson,
  });
  final int schemaVersion;
  final String createdAtIso;
  final String devicesJson;
  final String settingsJson;
  final String adapterMetadataJson;
  Map<String, Object?> toJson() => {
    'schemaVersion': schemaVersion,
    'createdAtIso': createdAtIso,
    'devicesJson': devicesJson,
    'settingsJson': settingsJson,
    'adapterMetadataJson': adapterMetadataJson,
  };
}
