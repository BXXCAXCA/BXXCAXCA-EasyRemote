import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/http_request_descriptor.dart';
import 'package:easyremote/src/services/webdav_request_builder.dart';

void main() {
  test('builds list descriptor', () {
    final builder = WebDavRequestBuilder(baseUrl: Uri.parse('https://example.invalid/dav'));
    final request = builder.list('/config');

    expect(request.method, HttpMethod.propfind);
    expect(request.url.toString(), 'https://example.invalid/dav/config');
    expect(request.headers['Depth'], '1');
  });

  test('builds read descriptor', () {
    final builder = WebDavRequestBuilder(baseUrl: Uri.parse('https://example.invalid/dav/'));
    final request = builder.readText('config/settings.json');

    expect(request.method, HttpMethod.get);
    expect(request.url.toString(), 'https://example.invalid/dav/config/settings.json');
  });

  test('builds write descriptor', () {
    final builder = WebDavRequestBuilder(baseUrl: Uri.parse('https://example.invalid/dav'));
    final request = builder.writeText(path: 'config/settings.json', content: '{}');

    expect(request.method, HttpMethod.put);
    expect(request.body, '{}');
    expect(request.headers['Content-Type'], contains('text/plain'));
  });
}
