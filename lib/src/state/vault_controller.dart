import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/vault_record.dart';
import '../models/vault_state.dart';
import '../repositories/vault_repository.dart';
import '../services/vault_crypto_service.dart';

class VaultController extends ChangeNotifier {
  VaultController({
    required VaultRepository repository,
    VaultCryptoService? cryptoService,
  })  : _repository = repository,
        _cryptoService = cryptoService ?? DemoVaultCryptoService();

  final VaultRepository _repository;
  final VaultCryptoService _cryptoService;
  VaultState _state = VaultState.locked();
  List<VaultRecord> _records = [];
  String? _sessionKey;

  VaultState get state => _state;
  List<VaultRecord> get records => List.unmodifiable(_records);

  Future<void> unlock(String passphrase) async {
    if (passphrase.trim().isEmpty) {
      _state = const VaultState(status: VaultStatus.locked, message: 'Passphrase is required');
    } else {
      _sessionKey = passphrase;
      _records = await _repository.loadRecords();
      _state = const VaultState(status: VaultStatus.unlocked, message: 'Vault unlocked for this session');
    }
    notifyListeners();
  }

  void lock() {
    _sessionKey = null;
    _state = VaultState.locked();
    notifyListeners();
  }

  Future<void> addDemoRecord({
    required String label,
    required String kind,
    required String plainText,
  }) async {
    if (_sessionKey == null) return;
    final now = DateTime.now().toIso8601String();
    final record = VaultRecord(
      id: const Uuid().v4(),
      label: label,
      kind: kind,
      cipherText: _cryptoService.encryptForDemo(plainText: plainText, sessionKey: _sessionKey!),
      createdAtIso: now,
      updatedAtIso: now,
    );
    await _repository.saveRecord(record);
    _records = await _repository.loadRecords();
    notifyListeners();
  }
}
