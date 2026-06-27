import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/services/services.dart' as services;

void main() {
  test('service barrel exports transport WebDAV client', () {
    final transport = services.FakeHttpTransport();
    final client = services.TransportWebDavClient(
      builder: services.WebDavRequestBuilder(baseUrl: Uri.parse('https://example.invalid/dav')),
      transport: transport,
    );

    expect(client, isA<services.WebDavClient>());
  });
}
