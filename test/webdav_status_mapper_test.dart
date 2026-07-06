import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';
import 'package:easyremote/src/services/webdav_status_mapper.dart';

void main() {
  test('maps auth status', () {
    expect(const WebDavStatusMapper().mapStatus(401), AppErrorCode.authRequired);
  });

  test('maps forbidden status', () {
    expect(const WebDavStatusMapper().mapStatus(403), AppErrorCode.permissionDenied);
  });

  test('maps not found status', () {
    expect(const WebDavStatusMapper().mapStatus(404), AppErrorCode.remoteNotFound);
  });

  test('maps conflict-like statuses', () {
    const mapper = WebDavStatusMapper();
    expect(mapper.mapStatus(409), AppErrorCode.conflictDetected);
    expect(mapper.mapStatus(412), AppErrorCode.conflictDetected);
    expect(mapper.mapStatus(423), AppErrorCode.conflictDetected);
  });

  test('maps validation and server statuses', () {
    const mapper = WebDavStatusMapper();
    expect(mapper.mapStatus(400), AppErrorCode.validationFailed);
    expect(mapper.mapStatus(422), AppErrorCode.validationFailed);
    expect(mapper.mapStatus(500), AppErrorCode.networkUnavailable);
  });
}
