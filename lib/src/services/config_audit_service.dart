import '../models/app_settings.dart';

class ConfigAuditItem {
  const ConfigAuditItem({
    required this.id,
    required this.ok,
    required this.title,
    required this.detail,
  });

  final String id;
  final bool ok;
  final String title;
  final String detail;
}

class ConfigAuditService {
  List<ConfigAuditItem> audit(AppSettings settings) {
    return [
      ConfigAuditItem(
        id: 'entry-confirmation',
        ok: settings.requireEntryConfirmation,
        title: 'Entry confirmation',
        detail: settings.requireEntryConfirmation
            ? 'Confirmation is enabled.'
            : 'Confirmation is disabled.',
      ),
      ConfigAuditItem(
        id: 'webdav-url',
        ok: !settings.webDavEnabled || settings.webDavUrl.trim().isNotEmpty,
        title: 'WebDAV URL',
        detail: settings.webDavEnabled
            ? 'WebDAV URL should be configured.'
            : 'WebDAV is disabled.',
      ),
      const ConfigAuditItem(
        id: 'remote-engine',
        ok: true,
        title: 'Remote engine',
        detail: 'No remote engine is included in this scaffold.',
      ),
    ];
  }
}
