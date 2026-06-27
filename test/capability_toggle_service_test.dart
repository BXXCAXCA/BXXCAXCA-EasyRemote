import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/services/capability_toggle_service.dart';

void main() {
  test('capability list includes enabled and disabled items', () {
    final items = CapabilityToggleService().list();
    expect(items.any((item) => item.enabled), isTrue);
    expect(items.any((item) => !item.enabled), isTrue);
  });
}
