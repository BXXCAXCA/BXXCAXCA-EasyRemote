import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';
import 'package:easyremote/src/services/webdav_operation_result.dart';

void main() {
  test('operation result supports success state', () {
    final result = WebDavOperationResult.ok(statusCode: 204);

    expect(result.success, isTrue);
    expect(result.statusCode, 204);
    expect(result.errorCode, isNull);
  });

  test('operation result supports failed state', () {
    final result = WebDavOperationResult.failed(
      statusCode: 404,
      errorCode: AppErrorCode.remoteNotFound,
    );

    expect(result.success, isFalse);
    expect(result.statusCode, 404);
    expect(result.errorCode, AppErrorCode.remoteNotFound);
  });
}
