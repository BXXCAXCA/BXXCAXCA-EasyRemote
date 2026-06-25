import 'package:flutter/material.dart';
import '../../state/vault_controller.dart';

class VaultUnlockPage extends StatefulWidget {
  const VaultUnlockPage({super.key, required this.controller});
  final VaultController controller;

  @override
  State<VaultUnlockPage> createState() => _VaultUnlockPageState();
}

class _VaultUnlockPageState extends State<VaultUnlockPage> {
  final passphraseController = TextEditingController();
  final labelController = TextEditingController(text: 'Demo secret');
  final secretController = TextEditingController(text: 'placeholder');

  @override
  void dispose() {
    passphraseController.dispose();
    labelController.dispose();
    secretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('Vault')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                leading: Icon(widget.controller.state.isUnlocked ? Icons.lock_open : Icons.lock_outline),
                title: Text(widget.controller.state.isUnlocked ? 'Unlocked' : 'Locked'),
                subtitle: Text(widget.controller.state.message),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passphraseController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Session passphrase', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => widget.controller.unlock(passphraseController.text),
              icon: const Icon(Icons.lock_open_outlined),
              label: const Text('Unlock for session'),
            ),
            const SizedBox(height: 8),
            TextButton.icon(onPressed: widget.controller.lock, icon: const Icon(Icons.lock_outline), label: const Text('Lock')),
            if (widget.controller.state.isUnlocked) ...[
              const Divider(height: 32),
              Text('Demo vault record', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              TextField(controller: labelController, decoration: const InputDecoration(labelText: 'Label', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              TextField(controller: secretController, obscureText: true, decoration: const InputDecoration(labelText: 'Secret value', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: () => widget.controller.addDemoRecord(label: labelController.text.trim(), kind: 'demo', plainText: secretController.text),
                icon: const Icon(Icons.add),
                label: const Text('Add demo encrypted record'),
              ),
              const SizedBox(height: 12),
              ...widget.controller.records.map((record) => Card(child: ListTile(leading: const Icon(Icons.key_outlined), title: Text(record.label), subtitle: Text('${record.kind} · ${record.updatedAtIso}')))),
            ],
            const SizedBox(height: 24),
            const Text('DemoVaultCryptoService is not production encryption. Replace it with authenticated encryption before real secret storage.'),
          ],
        ),
      ),
    );
  }
}
