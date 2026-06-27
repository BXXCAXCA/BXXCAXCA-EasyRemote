import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/services/http_webdav_client_boundary.dart';
import 'package:easyremote/src/services/webdav_client.dart';

void main() {
  test('webdav boundary implements client interface', () {
    final client = HttpWebDavClientBoundary(baseUrl: 'https://example.invalid');
    expect(client, isA<WebDavClient>());
  });

  test('webdav boundary is intentionally not wired', () async {
    final client = HttpWebDavClientBoundary(baseUrl: 'https://example.invalid');
    expect(client.ping(), throwsA(isA<UnimplementedError>()));
  });

  test('webdav resource carries metadata', () {
    const resource = WebDavResource(path: '/config.json', isDirectory: false, sizeBytes: 12);
    expect(resource.path, '/config.json');
    expect(resource.isDirectory, isFalse);
  });
}
