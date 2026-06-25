abstract class PlatformKeystoreService {
  Future<bool> isAvailable();

  Future<void> saveWrappedKey({
    required String keyId,
    required String wrappedKey,
  });

  Future<String?> readWrappedKey(String keyId);

  Future<void> deleteWrappedKey(String keyId);
}

class UnavailablePlatformKeystoreService implements PlatformKeystoreService {
  @override
  Future<bool> isAvailable() async => false;

  @override
  Future<void> saveWrappedKey({
    required String keyId,
    required String wrappedKey,
  }) async {
    throw UnsupportedError('Platform keystore is not implemented yet.');
  }

  @override
  Future<String?> readWrappedKey(String keyId) async => null;

  @override
  Future<void> deleteWrappedKey(String keyId) async {}
}
