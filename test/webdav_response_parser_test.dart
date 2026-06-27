import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/services/webdav_response_parser.dart';

void main() {
  test('parses DAV response fixture into resources', () {
    const body = '''
<d:multistatus xmlns:d="DAV:">
  <d:response>
    <d:href>/dav/config/</d:href>
    <d:propstat>
      <d:prop>
        <d:resourcetype><d:collection/></d:resourcetype>
        <d:getlastmodified>Sat, 27 Jun 2026 00:00:00 GMT</d:getlastmodified>
      </d:prop>
    </d:propstat>
  </d:response>
  <d:response>
    <d:href>/dav/config/settings.json</d:href>
    <d:propstat>
      <d:prop>
        <d:getcontentlength>42</d:getcontentlength>
        <d:getlastmodified>Sat, 27 Jun 2026 00:01:00 GMT</d:getlastmodified>
      </d:prop>
    </d:propstat>
  </d:response>
</d:multistatus>
''';

    final resources = const WebDavResponseParser().parseResources(body);

    expect(resources, hasLength(2));
    expect(resources.first.isDirectory, isTrue);
    expect(resources.last.path, '/dav/config/settings.json');
    expect(resources.last.sizeBytes, 42);
  });

  test('parser skips response blocks without href', () {
    const body = '<d:response><d:propstat /></d:response>';
    expect(const WebDavResponseParser().parseResources(body), isEmpty);
  });
}
