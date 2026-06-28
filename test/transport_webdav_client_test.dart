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

  test('transport WebDAV client ping uses fake response', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/'] = const HttpResponseDescriptor(
      statusCode: 207,
      headers: {},
      body: '',
    );

    expect(await buildClient(transport).ping(), isTrue);
  });

  test('transport WebDAV client lists parsed resources', () async {
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

    final resources = await buildClient(transport).list('config');
    expect(resources, hasLength(1));
    expect(resources.first.path, '/dav/config/settings.json');
  });

  test('transport WebDAV client reads text body', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/config/settings.json'] = const HttpResponseDescriptor(
      statusCode: 200,
      headers: {},
      body: '{"ok":true}',
    );

    final body = await buildClient(transport).readText('config/settings.json');
    expect(body, contains('ok'));
  });

  test('transport WebDAV client tryReadText returns success result', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/config/settings.json'] = const HttpResponseDescriptor(
      statusCode: 200,
      headers: {},
      body: '{"ok":true}',
    );

    final result = await buildClient(transport).tryReadText('config/settings.json');
    expect(result.success, isTrue);
    expect(result.statusCode, 200);
    expect(result.content, contains('ok'));
  });

  test('transport WebDAV client tryReadText returns mapped failure result', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/config/settings.json'] = const HttpResponseDescriptor(
      statusCode: 404,
      headers: {},
      body: '',
    );

    final result = await buildClient(transport).tryReadText('config/settings.json');
    expect(result.success, isFalse);
    expect(result.statusCode, 404);
    expect(result.errorCode, AppErrorCode.remoteNotFound);
  });

  test('transport WebDAV client write accepts success response', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/config/settings.json'] = const HttpResponseDescriptor(
      statusCode: 204,
      headers: {},
      body: '',
    );

    await buildClient(transport).writeText(path: 'config/settings.json', content: '{}');
  });

  test('transport WebDAV client tryWriteText returns success result', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/config/settings.json'] = const HttpResponseDescriptor(
      statusCode: 204,
      headers: {},
      body: '',
    );

    final result = await buildClient(transport).tryWriteText(path: 'config/settings.json', content: '{}');
    expect(result.success, isTrue);
    expect(result.statusCode, 204);
  });

  test('transport WebDAV client tryWriteText returns mapped failure result', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/config/settings.json'] = const HttpResponseDescriptor(
      statusCode: 401,
      headers: {},
      body: '',
    );

    final result = await buildClient(transport).tryWriteText(path: 'config/settings.json', content: '{}');
    expect(result.success, isFalse);
    expect(result.errorCode, AppErrorCode.authRequired);
  });

  test('transport WebDAV client write reports mapped auth error', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/config/settings.json'] = const HttpResponseDescriptor(
      statusCode: 401,
      headers: {},
      body: '',
    );

    expect(
      buildClient(transport).writeText(path: 'config/settings.json', content: '{}'),
      throwsA(isA<StateError>().having((error) => error.message, 'message', contains('authRequired'))),
    );
  });

  test('transport WebDAV client write reports mapped missing resource error', () async {
    final transport = FakeHttpTransport();
    expect(
      buildClient(transport).writeText(path: 'config/missing.json', content: '{}'),
      throwsA(isA<StateError>().having((error) => error.message, 'message', contains('remoteNotFound'))),
    );
  });
}
