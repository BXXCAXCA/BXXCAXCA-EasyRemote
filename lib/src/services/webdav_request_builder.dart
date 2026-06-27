import '../models/http_request_descriptor.dart';

class WebDavRequestBuilder {
  const WebDavRequestBuilder({required this.baseUrl});

  final Uri baseUrl;

  HttpRequestDescriptor ping() => HttpRequestDescriptor(
        method: HttpMethod.propfind,
        url: _resolve('/'),
        headers: const {'Depth': '0'},
      );

  HttpRequestDescriptor list(String path) => HttpRequestDescriptor(
        method: HttpMethod.propfind,
        url: _resolve(path),
        headers: const {'Depth': '1'},
      );

  HttpRequestDescriptor readText(String path) => HttpRequestDescriptor(
        method: HttpMethod.get,
        url: _resolve(path),
        headers: const {},
      );

  HttpRequestDescriptor writeText({required String path, required String content}) => HttpRequestDescriptor(
        method: HttpMethod.put,
        url: _resolve(path),
        headers: const {'Content-Type': 'text/plain; charset=utf-8'},
        body: content,
      );

  Uri _resolve(String path) {
    final normalizedBase = baseUrl.toString().endsWith('/') ? baseUrl : Uri.parse('${baseUrl.toString()}/');
    final normalizedPath = path.startsWith('/') ? path.substring(1) : path;
    return normalizedBase.resolve(normalizedPath);
  }
}
