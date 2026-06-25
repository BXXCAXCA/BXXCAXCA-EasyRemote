abstract class VaultService {
  Future<void> putSecret({
    required String key,
    required String plainText,
  });

  Future<String?> getSecret(String key);

  Future<void> deleteSecret(String key);
}

class PlaceholderVaultService implements VaultService {
  final Map<String, String> _memory = {};

  @override
  Future<void> putSecret({
    required String key,
    required String plainText,
  }) async {
    // Placeholder memory store. Replace with platform keystore + encrypted storage.
    _memory[key] = plainText;
  }

  @override
  Future<String?> getSecret(String key) async {
    return _memory[key];
  }

  @override
  Future<void> deleteSecret(String key) async {
    _memory.remove(key);
  }
}
