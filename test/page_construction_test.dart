import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/features/import_check/import_check_page.dart';
import 'package:easyremote/src/features/work_items/work_items_page.dart';
import 'package:easyremote/src/features/migrations/migration_status_page.dart';

void main() {
  test('simple pages can be constructed', () {
    expect(const ImportCheckPage(), isNotNull);
    expect(WorkItemsPage(), isNotNull);
    expect(MigrationStatusPage(), isNotNull);
  });
}
