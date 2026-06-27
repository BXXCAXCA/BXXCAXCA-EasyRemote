import 'http_transport.dart';
import 'webdav_client.dart';
import 'webdav_request_builder.dart';
import 'webdav_response_parser.dart';

class TransportWebDavClient implements WebDavClient {
  const TransportWebDavClient({
    required this.builder,
    required this.transport,
    this.parser = const WebDavResponseParser(),
  });

  final WebDavRequestBuilder builder;
  final HttpTransport transport;
  final WebDavResponseParser parser;

  @override
  Future<bool> ping() async {
    final response = await transport.send(builder.ping());
    return response.isSuccess;
  }

  @override
  Future<List<WebDavResource>> list(String path) async {
    final response = await transport.send(builder.list(path));
    if (!response.isSuccess) {
      return const [];
    }
    return parser.parseResources(response.body);
  }

  @override
  Future<String?> readText(String path) async {
    final response = await transport.send(builder.readText(path));
    if (!response.isSuccess) {
      return null;
    }
    return response.body;
  }

  @override
  Future<void> writeText({required String path, required String content}) async {
    final response = await transport.send(builder.writeText(path: path, content: content));
    if (!response.isSuccess) {
      throw StateError('WebDAV write descriptor failed with status ${response.statusCode}.');
    }
  }
}
