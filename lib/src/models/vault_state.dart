enum VaultStatus { locked, unlocked, unavailable }

class VaultState {
  const VaultState({required this.status, required this.message});
  factory VaultState.locked() => const VaultState(status: VaultStatus.locked, message: 'Vault is locked');
  final VaultStatus status;
  final String message;
  bool get isUnlocked => status == VaultStatus.unlocked;
}
