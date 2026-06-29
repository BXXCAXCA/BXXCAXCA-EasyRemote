import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';
import 'package:easyremote/src/models/http_request_descriptor.dart';
import 'package:easyremote/src/services/http_transport.dart';
import 'package:easyremote/src/services/transport_webdav_client.dart';
import 'package:easyremote/src/services/webdav_check_service.dart';
import 'package:easyremote/src/services/webdav_request_builder.dart';

void main() {
  WebDavCheckService buildService(FakeHttpTransport transport) {
    final client = TransportWebDavClient(
      builder: WebDavRequestBuilder(baseUrl: Uri.parse('https://example.invalid/dav')),
      transport: transport,
    );
    return WebDavCheckService(client: client);
  }

  test('check service reports ping and list success', () async {
    const body = '''
<d:multistatus xmlns:d="DAV:">
  <d:response>
    <d:href>/dav/config/settings.json</d:href>
    <d:propstat><d:prop><d:getcontentlength>2</d:getcontentlength></d:prop></d:propstat>
  </d:response>
</d:multistatus>
''';
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/'] = const HttpResponseDescriptor(
      statusCode: 207,
      headers: {},
      body: '',
    );
    transport.responses['https://example.invalid/dav/config'] = const HttpResponseDescriptor(
      statusCode: 207,
      headers: {},
      body: body,
    );

    final report = await buildService(transport).run(listPath: 'config');

    expect(report.ok, isTrue);
    expect(report.items, hasLength(2));
    expect(report.items.map((item) => item.id), containsAll(['ping', 'list']));
  });

  test('check service skips list after failed ping', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/'] = const HttpResponseDescriptor(
      statusCode: 401,
      headers: {},
      body: '',
    );

    final report = await buildService(transport).run(listPath: 'config');

    expect(report.ok, isFalse);
    expect(report.items.first.errorCode, AppErrorCode.authRequired);
    expect(report.items.last.id, 'list');
    expect(report.items.last.ok, isFalse);
    expect(report.items.last.detail, contains('Skipped'));
  });
}
