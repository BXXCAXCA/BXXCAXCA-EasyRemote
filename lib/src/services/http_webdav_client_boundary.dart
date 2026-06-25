import 'webdav_client.dart';

/// Boundary for a future real WebDAV HTTP implementation.
///
/// Phase 8 keeps this intentionally non-operational so the app can define
/// call sites, tests, and UI flow before wiring network transport.
class HttpWebDavClientBoundary implements WebDavClient {
  HttpWebDavClientBoundary({required this.baseUrl});

  final String baseUrl;

  @override
  Future<bool> ping() async {
    throw UnimplementedError('HTTP WebDAV ping is not implemented yet.');
  }

  @override
  Future<List<WebDavResource>> list(String path) async {
    throw UnimplementedError('HTTP WebDAV list is not implemented yet.');
  }

  @override
  Future<String?> readText(String path) async {
    throw UnimplementedError('HTTP WebDAV read is not implemented yet.');
  }

  @override
  Future<void> writeText({required String path, required String content}) async {
    throw UnimplementedError('HTTP WebDAV write is not implemented yet.');
  }
}
