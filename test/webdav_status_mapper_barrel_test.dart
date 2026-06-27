import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';
import 'package:easyremote/src/services/services.dart' as services;

void main() {
  test('service barrel exports WebDAV status mapper', () {
    expect(const services.WebDavStatusMapper().mapStatus(404), AppErrorCode.remoteNotFound);
  });
}
