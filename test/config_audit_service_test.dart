import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_settings.dart';
import 'package:easyremote/src/services/config_audit_service.dart';

void main() {
  test('audit reports confirmation enabled', () {
    final items = ConfigAuditService().audit(AppSettings.defaults());
    expect(items.any((item) => item.id == 'entry-confirmation' && item.ok), isTrue);
  });
}
