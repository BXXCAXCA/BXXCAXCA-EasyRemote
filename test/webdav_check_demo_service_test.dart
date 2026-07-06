import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_error_code.dart';
import 'package:easyremote/src/services/webdav_check_demo_service.dart';

void main() {
  test('demo mode labels are stable', () {
    expect(WebDavCheckDemoMode.success.label, 'Success');
    expect(WebDavCheckDemoMode.emptyFolder.label, 'Empty folder');
    expect(WebDavCheckDemoMode.authRequired.label, 'Auth required');
    expect(WebDavCheckDemoMode.forbidden.label, 'Forbidden');
    expect(WebDavCheckDemoMode.serverError.label, 'Server error');
    expect(WebDavCheckDemoMode.missingRoot.label, 'Missing root');
  });

  test('success demo returns passing report', () async {
    final report = await const WebDavCheckDemoService().run(mode: WebDavCheckDemoMode.success);

    expect(report.ok, isTrue);
    expect(report.summaryText, '2/2 checks passed');
    expect(report.items.last.detail, 'Found 1 resources at config.');
  });

  test('empty folder demo returns passing zero-resource report', () async {
    final report = await const WebDavCheckDemoService().run(mode: WebDavCheckDemoMode.emptyFolder);

    expect(report.ok, isTrue);
    expect(report.summaryText, '2/2 checks passed');
    expect(report.items.last.detail, 'Found 0 resources at config.');
  });

  test('auth required demo maps to auth error', () async {
    final report = await const WebDavCheckDemoService().run(mode: WebDavCheckDemoMode.authRequired);

    expect(report.ok, isFalse);
    expect(report.items.first.statusCode, 401);
    expect(report.items.first.errorCode, AppErrorCode.authRequired);
  });

  test('forbidden demo maps to permission denied error', () async {
    final report = await const WebDavCheckDemoService().run(mode: WebDavCheckDemoMode.forbidden);

    expect(report.ok, isFalse);
    expect(report.items.first.statusCode, 403);
    expect(report.items.first.errorCode, AppErrorCode.permissionDenied);
  });

  test('server error demo maps to network unavailable error', () async {
    final report = await const WebDavCheckDemoService().run(mode: WebDavCheckDemoMode.serverError);

    expect(report.ok, isFalse);
    expect(report.items.first.statusCode, 500);
    expect(report.items.first.errorCode, AppErrorCode.networkUnavailable);
  });

  test('missing root demo maps to remote not found error', () async {
    final report = await const WebDavCheckDemoService().run(mode: WebDavCheckDemoMode.missingRoot);

    expect(report.ok, isFalse);
    expect(report.items.first.statusCode, 404);
    expect(report.items.first.errorCode, AppErrorCode.remoteNotFound);
  });
}
