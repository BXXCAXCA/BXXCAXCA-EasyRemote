import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';
import 'package:easyremote/src/models/http_request_descriptor.dart';
import 'package:easyremote/src/services/http_transport.dart';
import 'package:easyremote/src/services/transport_webdav_client.dart';
import 'package:easyremote/src/services/webdav_request_builder.dart';

void main() {
  TransportWebDavClient buildClient(FakeHttpTransport transport) {
    return TransportWebDavClient(
      builder: WebDavRequestBuilder(baseUrl: Uri.parse('https://example.invalid/dav')),
      transport: transport,
    );
  }

  test('tryPing returns success status code', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/'] = const HttpResponseDescriptor(
      statusCode: 207,
      headers: {},
      body: '',
    );

    final result = await buildClient(transport).tryPing();

    expect(result.success, isTrue);
    expect(result.statusCode, 207);
    expect(result.errorCode, isNull);
  });

  test('tryPing returns mapped result for auth status', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/'] = const HttpResponseDescriptor(
      statusCode: 401,
      headers: {},
      body: '',
    );

    final result = await buildClient(transport).tryPing();

    expect(result.success, isFalse);
    expect(result.statusCode, 401);
    expect(result.errorCode, AppErrorCode.authRequired);
  });

  test('legacy ping returns bool from typed result', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/'] = const HttpResponseDescriptor(
      statusCode: 207,
      headers: {},
      body: '',
    );

    expect(await buildClient(transport).ping(), isTrue);
  });
}
