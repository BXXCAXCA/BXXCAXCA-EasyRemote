import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_settings.dart';
import 'package:easyremote/src/services/sync_dry_run_service.dart';

void main() {
  test('sync dry-run fails when disabled', () async {
    final result = await SyncDryRunService().check(AppSettings.defaults());
    expect(result.ok, isFalse);
  });

  test('sync dry-run passes when required fields are present', () async {
    final result = await SyncDryRunService().check(
      AppSettings.defaults().copyWith(
        webDavEnabled: true,
        webDavUrl: 'https://example.invalid/dav',
        webDavUsername: 'user',
      ),
    );
    expect(result.ok, isTrue);
  });
}
