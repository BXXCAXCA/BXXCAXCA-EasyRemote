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

  test('tryList returns parsed resources with status code', () async {
    const body = '''
<d:multistatus xmlns:d="DAV:">
  <d:response>
    <d:href>/dav/config/settings.json</d:href>
    <d:propstat><d:prop><d:getcontentlength>2</d:getcontentlength></d:prop></d:propstat>
  </d:response>
</d:multistatus>
''';
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/config'] = const HttpResponseDescriptor(
      statusCode: 207,
      headers: {},
      body: body,
    );

    final result = await buildClient(transport).tryList('config');

    expect(result.success, isTrue);
    expect(result.statusCode, 207);
    expect(result.resources, hasLength(1));
  });

  test('tryList returns mapped result for missing path', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/missing'] = const HttpResponseDescriptor(
      statusCode: 404,
      headers: {},
      body: '',
    );

    final result = await buildClient(transport).tryList('missing');

    expect(result.success, isFalse);
    expect(result.statusCode, 404);
    expect(result.resources, isEmpty);
    expect(result.errorCode, AppErrorCode.remoteNotFound);
  });
}
