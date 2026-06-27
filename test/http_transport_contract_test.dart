import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/http_request_descriptor.dart';
import 'package:easyremote/src/services/http_transport.dart';

void main() {
  test('fake transport returns configured response', () async {
    final transport = FakeHttpTransport();
    final request = HttpRequestDescriptor(
      method: HttpMethod.get,
      url: Uri.parse('https://example.invalid/config.json'),
      headers: const {},
    );
    transport.responses[request.url.toString()] = const HttpResponseDescriptor(
      statusCode: 200,
      headers: {},
      body: '{}',
    );

    final response = await transport.send(request);
    expect(response.statusCode, 200);
    expect(response.isSuccess, isTrue);
  });

  test('fake transport returns 404 by default', () async {
    final transport = FakeHttpTransport();
    final response = await transport.send(HttpRequestDescriptor(
      method: HttpMethod.get,
      url: Uri.parse('https://example.invalid/missing.json'),
      headers: const {},
    ));

    expect(response.statusCode, 404);
    expect(response.isSuccess, isFalse);
  });
}
