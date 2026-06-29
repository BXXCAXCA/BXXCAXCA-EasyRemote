import 'package:flutter/material.dart';
import '../../models/http_request_descriptor.dart';
import '../../services/http_transport.dart';
import '../../services/transport_webdav_client.dart';
import '../../services/webdav_check_report.dart';
import '../../services/webdav_check_service.dart';
import '../../services/webdav_request_builder.dart';

class WebDavCheckPage extends StatefulWidget {
  const WebDavCheckPage({super.key});

  @override
  State<WebDavCheckPage> createState() => _WebDavCheckPageState();
}

class _WebDavCheckPageState extends State<WebDavCheckPage> {
  late final Future<WebDavCheckReport> _reportFuture;

  @override
  void initState() {
    super.initState();
    _reportFuture = _buildDemoService().run(listPath: 'config');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('WebDAV Check')),
        body: FutureBuilder<WebDavCheckReport>(
          future: _reportFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final report = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(
                      report.ok ? Icons.check_circle_outline : Icons.info_outline,
                    ),
                    title: const Text('WebDAV check preview'),
                    subtitle: Text(report.ok ? 'All demo checks passed.' : 'Some demo checks need attention.'),
                  ),
                ),
                const SizedBox(height: 12),
                ...report.items.map(
                  (item) => Card(
                    child: ListTile(
                      leading: Icon(item.ok ? Icons.check_outlined : Icons.error_outline),
                      title: Text(item.title),
                      subtitle: Text(item.detail),
                      trailing: item.statusCode == null ? null : Text('${item.statusCode}'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

  WebDavCheckService _buildDemoService() {
    const body = '''
<d:multistatus xmlns:d="DAV:">
  <d:response>
    <d:href>/dav/config/settings.json</d:href>
    <d:propstat><d:prop><d:getcontentlength>2</d:getcontentlength></d:prop></d:propstat>
  </d:response>
</d:multistatus>
''';
    final transport = FakeHttpTransport();
    transport.responses['https://example.invalid/dav/'] = const HttpResponseDescriptor(
      statusCode: 207,
      headers: {},
      body: '',
    );
    transport.responses['https://example.invalid/dav/config'] = const HttpResponseDescriptor(
      statusCode: 207,
      headers: {},
      body: body,
    );
    final client = TransportWebDavClient(
      builder: WebDavRequestBuilder(baseUrl: Uri.parse('https://example.invalid/dav')),
      transport: transport,
    );
    return WebDavCheckService(client: client);
  }
}
