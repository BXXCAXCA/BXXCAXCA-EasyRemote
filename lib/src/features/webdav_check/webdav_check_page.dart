import 'package:flutter/material.dart';
import '../../services/webdav_check_demo_service.dart';
import '../../services/webdav_check_report.dart';

class WebDavCheckPage extends StatefulWidget {
  const WebDavCheckPage({super.key});

  @override
  State<WebDavCheckPage> createState() => _WebDavCheckPageState();
}

class _WebDavCheckPageState extends State<WebDavCheckPage> {
  final WebDavCheckDemoService _demoService = const WebDavCheckDemoService();
  WebDavCheckDemoMode _mode = WebDavCheckDemoMode.success;
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
                          children: WebDavCheckDemoMode.values
                              .map(
                                (mode) => ChoiceChip(
                                  label: Text(mode.label),
                                  selected: _mode == mode,
                                  onSelected: (_) => _selectMode(mode),
                                ),
                              )
                              .toList(growable: false),
                        ),
                        const SizedBox(height: 8),
                        Text(_mode.description),
                        const SizedBox(height: 4),
                        Text('Expected response: ${_mode.expectedStatusText}'),
                        const SizedBox(height: 4),
                        Text('Suggested action: ${_mode.suggestedAction}'),
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

  void _selectMode(WebDavCheckDemoMode mode) {
    setState(() {
      _mode = mode;
      _reportFuture = _runCheck(mode);
    });
  }

  Future<WebDavCheckReport> _runCheck(WebDavCheckDemoMode mode) => _demoService.run(mode: mode);
}
