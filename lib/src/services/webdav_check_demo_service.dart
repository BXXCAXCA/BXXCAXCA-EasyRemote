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

  String get description {
    switch (this) {
      case WebDavCheckDemoMode.success:
        return 'Server is reachable and config contains one resource.';
      case WebDavCheckDemoMode.emptyFolder:
        return 'Server is reachable and config is empty.';
      case WebDavCheckDemoMode.authRequired:
        return 'Server requires authentication before listing.';
      case WebDavCheckDemoMode.forbidden:
        return 'Server denies access for the current account.';
      case WebDavCheckDemoMode.serverError:
        return 'Server returns a temporary failure.';
      case WebDavCheckDemoMode.missingRoot:
        return 'Server root path cannot be found.';
    }
  }

  String get suggestedAction {
    switch (this) {
      case WebDavCheckDemoMode.success:
        return 'Continue with sync preview or save configuration.';
      case WebDavCheckDemoMode.emptyFolder:
        return 'Create initial config files before syncing.';
      case WebDavCheckDemoMode.authRequired:
        return 'Check username, password, token, or app password settings.';
      case WebDavCheckDemoMode.forbidden:
        return 'Verify account permissions for the selected WebDAV path.';
      case WebDavCheckDemoMode.serverError:
        return 'Retry later or check the WebDAV server status.';
      case WebDavCheckDemoMode.missingRoot:
        return 'Check the base URL and remote root path.';
    }
  }

  int get expectedStatusCode {
    switch (this) {
      case WebDavCheckDemoMode.authRequired:
        return 401;
      case WebDavCheckDemoMode.forbidden:
        return 403;
      case WebDavCheckDemoMode.serverError:
        return 500;
      case WebDavCheckDemoMode.missingRoot:
        return 404;
      case WebDavCheckDemoMode.success:
      case WebDavCheckDemoMode.emptyFolder:
        return 207;
    }
  }

  String get expectedStatusText {
    switch (this) {
      case WebDavCheckDemoMode.success:
      case WebDavCheckDemoMode.emptyFolder:
        return '207 Multi-Status';
      case WebDavCheckDemoMode.authRequired:
        return '401 Unauthorized';
      case WebDavCheckDemoMode.forbidden:
        return '403 Forbidden';
      case WebDavCheckDemoMode.serverError:
        return '500 Server error';
      case WebDavCheckDemoMode.missingRoot:
        return '404 Not found';
    }
  }

  String get expectedOutcome {
    switch (this) {
      case WebDavCheckDemoMode.success:
      case WebDavCheckDemoMode.emptyFolder:
        return 'Pass';
      case WebDavCheckDemoMode.authRequired:
      case WebDavCheckDemoMode.forbidden:
      case WebDavCheckDemoMode.serverError:
      case WebDavCheckDemoMode.missingRoot:
        return 'Needs attention';
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
      statusCode: mode.expectedStatusCode,
      headers: const {},
      body: '',
    );
    if (mode == WebDavCheckDemoMode.success || mode == WebDavCheckDemoMode.emptyFolder) {
      transport.responses['https://example.invalid/dav/config'] = HttpResponseDescriptor(
        statusCode: mode.expectedStatusCode,
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
