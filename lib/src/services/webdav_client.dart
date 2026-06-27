class WebDavResource {
  const WebDavResource({
    required this.path,
    required this.isDirectory,
    this.sizeBytes,
    this.modifiedAtIso,
  });

  final String path;
  final bool isDirectory;
  final int? sizeBytes;
  final String? modifiedAtIso;
}

abstract class WebDavClient {
  Future<bool> ping();

  Future<List<WebDavResource>> list(String path);

  Future<String?> readText(String path);

  Future<void> writeText({required String path, required String content});
}
