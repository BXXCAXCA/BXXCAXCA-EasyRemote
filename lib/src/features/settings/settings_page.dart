import 'package:flutter/material.dart';
import '../../models/app_settings.dart';
import '../../state/settings_controller.dart';
import '../../state/vault_controller.dart';
import '../vault/vault_unlock_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.controller,
    required this.vaultController,
  });

  final SettingsController controller;
  final VaultController vaultController;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final webDavUrlController = TextEditingController();
  final webDavUsernameController = TextEditingController();

  @override
  void dispose() {
    webDavUrlController.dispose();
    webDavUsernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([widget.controller, widget.vaultController]),
      builder: (context, _) {
        final settings = widget.controller.settings;
        final vault = widget.vaultController.state;
        webDavUrlController.text = settings.webDavUrl;
        webDavUsernameController.text = settings.webDavUsername;

        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text('Vault'),
                subtitle: Text(vault.message),
                trailing: FilledButton.tonal(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => VaultUnlockPage(controller: widget.vaultController))),
                  child: Text(vault.isUnlocked ? 'Manage' : 'Unlock'),
                ),
              ),
              const SizedBox(height: 12),
              Text('WebDAV', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('WebDAV sync'),
                subtitle: const Text('Enable configuration sync planning'),
                value: settings.webDavEnabled,
                onChanged: (value) => widget.controller.update(settings.copyWith(webDavEnabled: value)),
              ),
              TextField(
                controller: webDavUrlController,
                decoration: const InputDecoration(labelText: 'WebDAV URL', border: OutlineInputBorder()),
                onSubmitted: (_) => _saveWebDav(settings),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: webDavUsernameController,
                decoration: const InputDecoration(labelText: 'WebDAV username', border: OutlineInputBorder()),
                onSubmitted: (_) => _saveWebDav(settings),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: () => _saveWebDav(settings),
                icon: const Icon(Icons.save_outlined),
                label: const Text('Save WebDAV settings'),
              ),
              const Divider(height: 32),
              SwitchListTile(
                title: const Text('Require entry confirmation'),
                subtitle: const Text('Ask before launching any future external entry'),
                value: settings.requireEntryConfirmation,
                onChanged: (value) => widget.controller.update(settings.copyWith(requireEntryConfirmation: value)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveWebDav(AppSettings settings) {
    widget.controller.update(settings.copyWith(
      webDavUrl: webDavUrlController.text.trim(),
      webDavUsername: webDavUsernameController.text.trim(),
    ));
  }
}
