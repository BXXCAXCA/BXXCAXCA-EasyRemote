import 'package:flutter_test/flutter_test.dart';
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

  test('transport WebDAV client write accepts success response', () async {
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/config/settings.json'] = const HttpResponseDescriptor(
      statusCode: 204,
      headers: {},
      body: '',
    );

    await buildClient(transport).writeText(path: 'config/settings.json', content: '{}');
  });

  test('transport WebDAV client write throws on failed response', () async {
    final transport = FakeHttpTransport();
    expect(
      buildClient(transport).writeText(path: 'config/missing.json', content: '{}'),
      throwsA(isA<StateError>()),
    );
  });
}
