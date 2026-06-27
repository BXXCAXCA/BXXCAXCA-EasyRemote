import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/encrypted_payload_envelope.dart';
import 'package:easyremote/src/models/key_derivation_params.dart';
import 'package:easyremote/src/services/production_crypto_adapter.dart';

void main() {
  test('production crypto placeholder implements adapter interface', () {
    final adapter = UnimplementedProductionCryptoAdapter();
    expect(adapter, isA<ProductionCryptoAdapter>());
  });

  test('production crypto placeholder encrypt is not wired', () {
    final adapter = UnimplementedProductionCryptoAdapter();
    final result = adapter.encrypt(
      plainText: 'demo',
      passphrase: 'passphrase',
      params: KeyDerivationParams.recommendedPlaceholder(),
    );
    expect(result, throwsA(isA<UnimplementedError>()));
  });

  test('production crypto placeholder decrypt is not wired', () {
    final adapter = UnimplementedProductionCryptoAdapter();
    const envelope = EncryptedPayloadEnvelope(
      schemaVersion: 1,
      algorithm: 'placeholder',
      cipherText: 'cipher',
      createdAtIso: '2026-01-01T00:00:00Z',
    );
    expect(adapter.decrypt(envelope: envelope, passphrase: 'passphrase'), throwsA(isA<UnimplementedError>()));
  });
}
