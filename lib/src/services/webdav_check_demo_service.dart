import '../models/http_request_descriptor.dart';
import 'http_transport.dart';
import 'transport_webdav_client.dart';
import 'webdav_check_report.dart';
import 'webdav_check_service.dart';
import 'webdav_request_builder.dart';

enum WebDavCheckDemoMode {
  success,
  emptyFolder,
  authRequired,
  forbidden,
  serverError,
  missingRoot,
}

extension WebDavCheckDemoModeLabel on WebDavCheckDemoMode {
  String get label {
    switch (this) {
      case WebDavCheckDemoMode.success:
        return 'Success';
      case WebDavCheckDemoMode.emptyFolder:
        return 'Empty folder';
      case WebDavCheckDemoMode.authRequired:
        return 'Auth required';
      case WebDavCheckDemoMode.forbidden:
        return 'Forbidden';
      case WebDavCheckDemoMode.serverError:
        return 'Server error';
      case WebDavCheckDemoMode.missingRoot:
        return 'Missing root';
    }
  }
}

class WebDavCheckDemoService {
  const WebDavCheckDemoService();

  Future<WebDavCheckReport> run({
    required WebDavCheckDemoMode mode,
    String listPath = 'config',
  }) =>
      _buildCheckService(mode).run(listPath: listPath);

  WebDavCheckService _buildCheckService(WebDavCheckDemoMode mode) {
    const body = '''
<d:multistatus xmlns:d="DAV:">
  <d:response>
    <d:href>/dav/config/settings.json</d:href>
    <d:propstat><d:prop><d:getcontentlength>2</d:getcontentlength></d:prop></d:propstat>
  </d:response>
</d:multistatus>
''';
    const emptyBody = '''
<d:multistatus xmlns:d="DAV:">
</d:multistatus>
''';
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/'] = HttpResponseDescriptor(
      statusCode: switch (mode) {
        WebDavCheckDemoMode.authRequired => 401,
        WebDavCheckDemoMode.forbidden => 403,
        WebDavCheckDemoMode.serverError => 500,
        WebDavCheckDemoMode.missingRoot => 404,
        _ => 207,
      },
      headers: const {},
      body: '',
    );
    if (mode == WebDavCheckDemoMode.success || mode == WebDavCheckDemoMode.emptyFolder) {
      transport.responses['https://example.invalid/dav/config'] = HttpResponseDescriptor(
        statusCode: 207,
        headers: const {},
        body: mode == WebDavCheckDemoMode.emptyFolder ? emptyBody : body,
      );
    }
    final client = TransportWebDavClient(
      builder: WebDavRequestBuilder(baseUrl: Uri.parse('https://example.invalid/dav')),
      transport: transport,
    );
    return WebDavCheckService(client: client);
  }
}
