import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/services/vault_crypto_service.dart';

void main() {
  test('demo vault codec roundtrips text', () {
    final service = DemoVaultCryptoService();
    final cipherText = service.encryptForDemo(plainText: 'secret', sessionKey: 'key');
    final plainText = service.decryptForDemo(cipherText: cipherText, sessionKey: 'key');
    expect(plainText, 'secret');
  });
}
