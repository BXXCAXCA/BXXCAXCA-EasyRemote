import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';
import 'package:easyremote/src/models/http_request_descriptor.dart';
import 'package:easyremote/src/services/http_error_mapper.dart';

void main() {
  test('maps auth status', () {
    const response = HttpResponseDescriptor(statusCode: 401, headers: {}, body: '');
    expect(HttpErrorMapper().map(response), AppErrorCode.authRequired);
  });

  test('maps not found status', () {
    const response = HttpResponseDescriptor(statusCode: 404, headers: {}, body: '');
    expect(HttpErrorMapper().map(response), AppErrorCode.remoteNotFound);
  });

  test('maps conflict status', () {
    const response = HttpResponseDescriptor(statusCode: 409, headers: {}, body: '');
    expect(HttpErrorMapper().map(response), AppErrorCode.conflictDetected);
  });

  test('maps server status', () {
    const response = HttpResponseDescriptor(statusCode: 503, headers: {}, body: '');
    expect(HttpErrorMapper().map(response), AppErrorCode.networkUnavailable);
  });
}
