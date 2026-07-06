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

  test('demo mode descriptions are stable', () {
    expect(WebDavCheckDemoMode.success.description, 'Server is reachable and config contains one resource.');
    expect(WebDavCheckDemoMode.emptyFolder.description, 'Server is reachable and config is empty.');
    expect(WebDavCheckDemoMode.authRequired.description, 'Server requires authentication before listing.');
    expect(WebDavCheckDemoMode.forbidden.description, 'Server denies access for the current account.');
    expect(WebDavCheckDemoMode.serverError.description, 'Server returns a temporary failure.');
    expect(WebDavCheckDemoMode.missingRoot.description, 'Server root path cannot be found.');
  });

  test('demo mode suggested actions are stable', () {
    expect(WebDavCheckDemoMode.success.suggestedAction, 'Continue with sync preview or save configuration.');
    expect(WebDavCheckDemoMode.emptyFolder.suggestedAction, 'Create initial config files before syncing.');
    expect(WebDavCheckDemoMode.authRequired.suggestedAction, 'Check username, password, token, or app password settings.');
    expect(WebDavCheckDemoMode.forbidden.suggestedAction, 'Verify account permissions for the selected WebDAV path.');
    expect(WebDavCheckDemoMode.serverError.suggestedAction, 'Retry later or check the WebDAV server status.');
    expect(WebDavCheckDemoMode.missingRoot.suggestedAction, 'Check the base URL and remote root path.');
  });

  test('demo mode expected status codes are stable', () {
    expect(WebDavCheckDemoMode.success.expectedStatusCode, 207);
    expect(WebDavCheckDemoMode.emptyFolder.expectedStatusCode, 207);
    expect(WebDavCheckDemoMode.authRequired.expectedStatusCode, 401);
    expect(WebDavCheckDemoMode.forbidden.expectedStatusCode, 403);
    expect(WebDavCheckDemoMode.serverError.expectedStatusCode, 500);
    expect(WebDavCheckDemoMode.missingRoot.expectedStatusCode, 404);
  });

  test('demo mode expected status text is stable', () {
    expect(WebDavCheckDemoMode.success.expectedStatusText, '207 Multi-Status');
    expect(WebDavCheckDemoMode.emptyFolder.expectedStatusText, '207 Multi-Status');
    expect(WebDavCheckDemoMode.authRequired.expectedStatusText, '401 Unauthorized');
    expect(WebDavCheckDemoMode.forbidden.expectedStatusText, '403 Forbidden');
    expect(WebDavCheckDemoMode.serverError.expectedStatusText, '500 Server error');
    expect(WebDavCheckDemoMode.missingRoot.expectedStatusText, '404 Not found');
  });

  test('demo mode expected outcomes are stable', () {
    expect(WebDavCheckDemoMode.success.expectedOutcome, 'Pass');
    expect(WebDavCheckDemoMode.emptyFolder.expectedOutcome, 'Pass');
    expect(WebDavCheckDemoMode.authRequired.expectedOutcome, 'Needs attention');
    expect(WebDavCheckDemoMode.forbidden.expectedOutcome, 'Needs attention');
    expect(WebDavCheckDemoMode.serverError.expectedOutcome, 'Needs attention');
    expect(WebDavCheckDemoMode.missingRoot.expectedOutcome, 'Needs attention');
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
