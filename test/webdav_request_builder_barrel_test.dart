import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/http_request_descriptor.dart';
import 'package:easyremote/src/services/services.dart' as services;

void main() {
  test('service barrel exports WebDAV request builder', () {
    final builder = services.WebDavRequestBuilder(baseUrl: Uri.parse('https://example.invalid/dav'));
    final request = builder.ping();

    expect(request.method, HttpMethod.propfind);
    expect(request.headers['Depth'], '0');
  });
}
