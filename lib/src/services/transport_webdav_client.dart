import 'http_transport.dart';
import 'webdav_client.dart';
import 'webdav_list_result.dart';
import 'webdav_operation_result.dart';
import 'webdav_read_result.dart';
import 'webdav_request_builder.dart';
import 'webdav_response_parser.dart';
import 'webdav_status_mapper.dart';

class TransportWebDavClient implements WebDavClient {
  const TransportWebDavClient({
    required this.builder,
    required this.transport,
    this.parser = const WebDavResponseParser(),
    this.statusMapper = const WebDavStatusMapper(),
  });

  final WebDavRequestBuilder builder;
  final HttpTransport transport;
  final WebDavResponseParser parser;
  final WebDavStatusMapper statusMapper;

  @override
  Future<bool> ping() async {
    final response = await transport.send(builder.ping());
    return response.isSuccess;
  }

  Future<WebDavListResult> tryList(String path) async {
    final response = await transport.send(builder.list(path));
    if (response.isSuccess) {
      return WebDavListResult.ok(
        statusCode: response.statusCode,
        resources: parser.parseResources(response.body),
      );
    }
    return WebDavListResult.failed(
      statusCode: response.statusCode,
      errorCode: statusMapper.mapStatus(response.statusCode),
    );
  }

  @override
  Future<List<WebDavResource>> list(String path) async {
    final result = await tryList(path);
    if (!result.success) {
      return const [];
    }
    return result.resources;
  }

  Future<WebDavReadResult> tryReadText(String path) async {
    final response = await transport.send(builder.readText(path));
    if (response.isSuccess) {
      return WebDavReadResult.ok(
        statusCode: response.statusCode,
        content: response.body,
      );
    }
    return WebDavReadResult.failed(
      statusCode: response.statusCode,
      errorCode: statusMapper.mapStatus(response.statusCode),
    );
  }

  @override
  Future<String?> readText(String path) async {
    final result = await tryReadText(path);
    if (!result.success) {
      return null;
    }
    return result.content;
  }

  Future<WebDavOperationResult> tryWriteText({required String path, required String content}) async {
    final response = await transport.send(builder.writeText(path: path, content: content));
    if (response.isSuccess) {
      return WebDavOperationResult.ok(statusCode: response.statusCode);
    }
    return WebDavOperationResult.failed(
      statusCode: response.statusCode,
      errorCode: statusMapper.mapStatus(response.statusCode),
    );
  }

  @override
  Future<void> writeText({required String path, required String content}) async {
    final result = await tryWriteText(path: path, content: content);
    if (!result.success) {
      throw StateError('WebDAV write failed: ${result.errorCode?.code}.');
    }
  }
}
