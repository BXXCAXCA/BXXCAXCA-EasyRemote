import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/services/vault_crypto_service.dart';

void main() {
  test('demo codec round trips text', () {
    final service = DemoVaultCryptoService();
    final encoded = service.encryptForDemo(plainText: 'hello', sessionKey: 'key');
    final decoded = service.decryptForDemo(cipherText: encoded, sessionKey: 'key');

    expect(decoded, 'hello');
    expect(encoded, isNot('hello'));
  });

  test('demo codec checks session value', () {
    final service = DemoVaultCryptoService();
    final encoded = service.encryptForDemo(plainText: 'hello', sessionKey: 'key');

    expect(
      () => service.decryptForDemo(cipherText: encoded, sessionKey: 'other'),
      throwsA(isA<StateError>()),
    );
  });
}
