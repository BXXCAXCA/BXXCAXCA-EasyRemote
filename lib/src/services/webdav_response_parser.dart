import 'webdav_client.dart';

class WebDavResponseParser {
  const WebDavResponseParser();

  List<WebDavResource> parseResources(String body) {
    final resources = <WebDavResource>[];
    final responsePattern = RegExp(
      r'<[^>]*response[^>]*>(.*?)</[^>]*response>',
      dotAll: true,
      caseSensitive: false,
    );

    for (final match in responsePattern.allMatches(body)) {
      final block = match.group(1) ?? '';
      final href = _firstTagValue(block, 'href');
      if (href == null || href.isEmpty) {
        continue;
      }

      resources.add(WebDavResource(
        path: href,
        isDirectory: _containsCollection(block),
        sizeBytes: _firstIntTagValue(block, 'getcontentlength'),
        modifiedAtIso: _firstTagValue(block, 'getlastmodified'),
      ));
    }

    return resources;
  }

  String? _firstTagValue(String block, String name) {
    final pattern = RegExp(
      '<[^>]*$name[^>]*>(.*?)</[^>]*$name>',
      dotAll: true,
      caseSensitive: false,
    );
    final match = pattern.firstMatch(block);
    return match?.group(1)?.trim();
  }

  int? _firstIntTagValue(String block, String name) {
    final value = _firstTagValue(block, name);
    if (value == null) return null;
    return int.tryParse(value);
  }

  bool _containsCollection(String block) {
    return RegExp(r'<[^>]*collection\s*/?>', caseSensitive: false).hasMatch(block);
  }
}
