import 'dart:convert';

abstract class VaultCryptoService {
  String encryptForDemo({
    required String plainText,
    required String sessionKey,
  });

  String decryptForDemo({
    required String cipherText,
    required String sessionKey,
  });
}

/// Non-production placeholder codec.
/// Replace before storing real secrets.
class DemoVaultCryptoService implements VaultCryptoService {
  @override
  String encryptForDemo({
    required String plainText,
    required String sessionKey,
  }) {
    return base64Encode(utf8.encode('$sessionKey::$plainText'));
  }

  @override
  String decryptForDemo({
    required String cipherText,
    required String sessionKey,
  }) {
    final decoded = utf8.decode(base64Decode(cipherText));
    final prefix = '$sessionKey::';
    if (!decoded.startsWith(prefix)) {
      throw StateError('Invalid session key');
    }
    return decoded.substring(prefix.length);
  }
}
