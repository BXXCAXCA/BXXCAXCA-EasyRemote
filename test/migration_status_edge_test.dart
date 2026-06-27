import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/services/migration_status_service.dart';

void main() {
  test('no pending migrations when current equals latest', () {
    final status = MigrationStatusService().calculate(currentVersion: 3, latestVersion: 3);
    expect(status.isUpToDate, isTrue);
    expect(status.pendingVersions, isEmpty);
  });
}
