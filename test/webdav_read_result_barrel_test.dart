import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';
import 'package:easyremote/src/services/services.dart' as services;

void main() {
  test('service barrel exports WebDAV read result', () {
    final result = services.WebDavReadResult.failed(
      statusCode: 404,
      errorCode: AppErrorCode.remoteNotFound,
    );

    expect(result.success, isFalse);
    expect(result.statusCode, 404);
    expect(result.errorCode, AppErrorCode.remoteNotFound);
  });
}
