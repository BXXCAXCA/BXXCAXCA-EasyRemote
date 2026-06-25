class VaultRecord {
  const VaultRecord({
    required this.id,
    required this.label,
    required this.kind,
    required this.cipherText,
    required this.createdAtIso,
    required this.updatedAtIso,
  });
  final String id;
  final String label;
  final String kind;
  final String cipherText;
  final String createdAtIso;
  final String updatedAtIso;
}
