import '../models/app_error_code.dart';
import 'transport_webdav_client.dart';
import 'webdav_check_report.dart';

class WebDavCheckService {
  const WebDavCheckService({required this.client});

  final TransportWebDavClient client;

  Future<WebDavCheckReport> run({String listPath = '/'}) async {
    final checkedAtIso = DateTime.now().toUtc().toIso8601String();
    final ping = await client.tryPing();
    final items = <WebDavCheckItem>[
      WebDavCheckItem(
        id: 'ping',
        ok: ping.success,
        title: 'Server reachability',
        detail: _detail(
          ok: ping.success,
          successText: 'Server responded with status ${ping.statusCode}.',
          errorCode: ping.errorCode,
          statusCode: ping.statusCode,
        ),
        statusCode: ping.statusCode,
        errorCode: ping.errorCode,
      ),
    ];

    if (ping.success) {
      final list = await client.tryList(listPath);
      items.add(
        WebDavCheckItem(
          id: 'list',
          ok: list.success,
          title: 'Directory listing',
          detail: _detail(
            ok: list.success,
            successText: 'Found ${list.resources.length} resources at $listPath.',
            errorCode: list.errorCode,
            statusCode: list.statusCode,
          ),
          statusCode: list.statusCode,
          errorCode: list.errorCode,
        ),
      );
    } else {
      items.add(
        const WebDavCheckItem(
          id: 'list',
          ok: false,
          title: 'Directory listing',
          detail: 'Skipped because server reachability did not pass.',
        ),
      );
    }

    return WebDavCheckReport(
      items: items,
      checkedAtIso: checkedAtIso,
    );
  }

  String _detail({
    required bool ok,
    required String successText,
    required AppErrorCode? errorCode,
    required int statusCode,
  }) {
    if (ok) {
      return successText;
    }
    return '${errorCode?.message ?? AppErrorCode.unknown.message} Status: $statusCode.';
  }
}
