class EncryptedPayloadEnvelope {
  const EncryptedPayloadEnvelope({
    required this.schemaVersion,
    required this.algorithm,
    required this.cipherText,
    required this.createdAtIso,
    this.keyParams,
  });

  final int schemaVersion;
  final String algorithm;
  final String cipherText;
  final String createdAtIso;
  final Map<String, Object?>? keyParams;

  Map<String, Object?> toJson() => {
        'schemaVersion': schemaVersion,
        'algorithm': algorithm,
        'cipherText': cipherText,
        'createdAtIso': createdAtIso,
        'keyParams': keyParams,
      };
}
