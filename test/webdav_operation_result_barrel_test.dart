import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';
import 'package:easyremote/src/services/services.dart' as services;

void main() {
  test('service barrel exports WebDAV operation result', () {
    final result = services.WebDavOperationResult.failed(
      statusCode: 404,
      errorCode: AppErrorCode.remoteNotFound,
    );

    expect(result.success, isFalse);
    expect(result.errorCode, AppErrorCode.remoteNotFound);
  });
}
