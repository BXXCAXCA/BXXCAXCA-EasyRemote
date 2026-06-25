import '../models/app_settings.dart';
import '../models/sync_dry_run_result.dart';

class SyncDryRunService {
  Future<SyncDryRunResult> check(AppSettings settings) async {
    final details = <String>[];

    if (!settings.webDavEnabled) {
      details.add('WebDAV sync is disabled.');
      return SyncDryRunResult(
        ok: false,
        title: 'Sync disabled',
        details: details,
        checkedAtIso: DateTime.now().toIso8601String(),
      );
    }

    if (settings.webDavUrl.trim().isEmpty) {
      details.add('WebDAV URL is empty.');
    } else {
      details.add('WebDAV URL is configured.');
    }

    if (settings.webDavUsername.trim().isEmpty) {
      details.add('WebDAV username is empty.');
    } else {
      details.add('WebDAV username is configured.');
    }

    details.add('No network request was sent. This is a dry-run validation only.');

    final ok = settings.webDavUrl.trim().isNotEmpty &&
        settings.webDavUsername.trim().isNotEmpty;

    return SyncDryRunResult(
      ok: ok,
      title: ok ? 'Dry-run passed' : 'Dry-run needs configuration',
      details: details,
      checkedAtIso: DateTime.now().toIso8601String(),
    );
  }
}
