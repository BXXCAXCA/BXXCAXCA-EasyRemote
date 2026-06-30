import 'package:flutter/material.dart';
import '../../models/http_request_descriptor.dart';
import '../../services/http_transport.dart';
import '../../services/transport_webdav_client.dart';
import '../../services/webdav_check_report.dart';
import '../../services/webdav_check_service.dart';
import '../../services/webdav_request_builder.dart';

enum _WebDavCheckDemoMode { success, emptyFolder, missingRoot }

class WebDavCheckPage extends StatefulWidget {
  const WebDavCheckPage({super.key});

  @override
  State<WebDavCheckPage> createState() => _WebDavCheckPageState();
}

class _WebDavCheckPageState extends State<WebDavCheckPage> {
  _WebDavCheckDemoMode _mode = _WebDavCheckDemoMode.success;
  late Future<WebDavCheckReport> _reportFuture;

  @override
  void initState() {
    super.initState();
    _reportFuture = _runCheck(_mode);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('WebDAV Check'),
          actions: [
            IconButton(
              tooltip: 'Refresh check',
              icon: const Icon(Icons.refresh),
              onPressed: _reload,
            ),
          ],
        ),
        body: FutureBuilder<WebDavCheckReport>(
          future: _reportFuture,
          builder: (context, snapshot) {
            final report = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Demo scenario'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            ChoiceChip(
                              label: const Text('Success'),
                              selected: _mode == _WebDavCheckDemoMode.success,
                              onSelected: (_) => _selectMode(_WebDavCheckDemoMode.success),
                            ),
                            ChoiceChip(
                              label: const Text('Empty folder'),
                              selected: _mode == _WebDavCheckDemoMode.emptyFolder,
                              onSelected: (_) => _selectMode(_WebDavCheckDemoMode.emptyFolder),
                            ),
                            ChoiceChip(
                              label: const Text('Missing root'),
                              selected: _mode == _WebDavCheckDemoMode.missingRoot,
                              onSelected: (_) => _selectMode(_WebDavCheckDemoMode.missingRoot),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (report == null)
                  const Center(child: CircularProgressIndicator())
                else ...[
                  Card(
                    child: ListTile(
                      leading: Icon(
                        report.ok ? Icons.check_circle_outline : Icons.info_outline,
                      ),
                      title: const Text('WebDAV check preview'),
                      subtitle: Text(
                        '${report.ok ? 'All demo checks passed.' : 'Some demo checks need attention.'}\n${report.summaryText}\nLast checked: ${report.checkedAtIso}',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...report.items.map(
                    (item) => Card(
                      child: ListTile(
                        leading: Icon(item.ok ? Icons.check_outlined : Icons.error_outline),
                        title: Text(item.title),
                        subtitle: Text(item.detail),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(item.statusLabel),
                            if (item.statusCode != null) Text('${item.statusCode}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      );

  void _reload() {
    setState(() {
      _reportFuture = _runCheck(_mode);
    });
  }

  void _selectMode(_WebDavCheckDemoMode mode) {
    setState(() {
      _mode = mode;
      _reportFuture = _runCheck(mode);
    });
  }

  Future<WebDavCheckReport> _runCheck(_WebDavCheckDemoMode mode) => _buildDemoService(mode).run(listPath: 'config');

  WebDavCheckService _buildDemoService(_WebDavCheckDemoMode mode) {
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
      statusCode: mode == _WebDavCheckDemoMode.missingRoot ? 404 : 207,
      headers: const {},
      body: '',
    );
    if (mode != _WebDavCheckDemoMode.missingRoot) {
      transport.responses['https://example.invalid/dav/config'] = HttpResponseDescriptor(
        statusCode: 207,
        headers: const {},
        body: mode == _WebDavCheckDemoMode.emptyFolder ? emptyBody : body,
      );
    }
    final client = TransportWebDavClient(
      builder: WebDavRequestBuilder(baseUrl: Uri.parse('https://example.invalid/dav')),
      transport: transport,
    );
    return WebDavCheckService(client: client);
  }
}
