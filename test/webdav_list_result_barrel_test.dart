import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';
import 'package:easyremote/src/services/services.dart' as services;

void main() {
  test('service barrel exports WebDAV list result', () {
    final result = services.WebDavListResult.failed(
      statusCode: 404,
      errorCode: AppErrorCode.remoteNotFound,
    );

    expect(result.success, isFalse);
    expect(result.statusCode, 404);
    expect(result.resources, isEmpty);
    expect(result.errorCode, AppErrorCode.remoteNotFound);
  });
}
