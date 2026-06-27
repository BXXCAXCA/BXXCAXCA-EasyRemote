import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';

void main() {
  test('error codes expose messages', () {
    expect(AppErrorCode.remoteNotFound.message, isNotEmpty);
    expect(AppErrorCode.operationNotImplemented.code, 'operationNotImplemented');
  });
}
