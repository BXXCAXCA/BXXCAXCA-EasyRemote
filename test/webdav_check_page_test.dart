import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/features/webdav_check/webdav_check_page.dart';

void main() {
  testWidgets('webdav check page renders success demo report', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WebDavCheckPage()));
    await tester.pumpAndSettle();

    expect(find.text('WebDAV Check'), findsOneWidget);
    expect(find.byTooltip('Refresh check'), findsOneWidget);
    expect(find.text('Demo scenario'), findsOneWidget);
    expect(find.text('Server is reachable and config contains one resource.'), findsOneWidget);
    expect(find.text('Expected response: 207 Multi-Status'), findsOneWidget);
    expect(find.text('Expected outcome: Pass'), findsOneWidget);
    expect(find.text('Suggested action: Continue with sync preview or save configuration.'), findsOneWidget);
    expect(find.text('WebDAV check preview'), findsOneWidget);
    expect(find.text('Empty folder'), findsOneWidget);
    expect(find.text('Auth required'), findsOneWidget);
    expect(find.text('Forbidden'), findsOneWidget);
    expect(find.text('Server error'), findsOneWidget);
    expect(find.textContaining('2/2 checks passed'), findsOneWidget);
    expect(find.textContaining('Last checked:'), findsOneWidget);
    expect(find.text('Server reachability'), findsOneWidget);
    expect(find.text('Directory listing'), findsOneWidget);
    expect(find.textContaining('All demo checks passed.'), findsOneWidget);
    expect(find.text('OK'), findsNWidgets(2));
  });

  testWidgets('webdav check page switches to empty folder demo report', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WebDavCheckPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Empty folder'));
    await tester.pumpAndSettle();

    expect(find.text('Server is reachable and config is empty.'), findsOneWidget);
    expect(find.text('Expected response: 207 Multi-Status'), findsOneWidget);
    expect(find.text('Expected outcome: Pass'), findsOneWidget);
    expect(find.text('Suggested action: Create initial config files before syncing.'), findsOneWidget);
    expect(find.textContaining('All demo checks passed.'), findsOneWidget);
    expect(find.textContaining('2/2 checks passed'), findsOneWidget);
    expect(find.text('Found 0 resources at config.'), findsOneWidget);
    expect(find.text('OK'), findsNWidgets(2));
  });

  testWidgets('webdav check page switches to auth required demo report', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WebDavCheckPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Auth required'));
    await tester.pumpAndSettle();

    expect(find.text('Server requires authentication before listing.'), findsOneWidget);
    expect(find.text('Expected response: 401 Unauthorized'), findsOneWidget);
    expect(find.text('Expected outcome: Needs attention'), findsOneWidget);
    expect(find.text('Suggested action: Check username, password, token, or app password settings.'), findsOneWidget);
    expect(find.textContaining('Some demo checks need attention.'), findsOneWidget);
    expect(find.textContaining('0/2 checks passed'), findsOneWidget);
    expect(find.text('Needs attention'), findsNWidgets(2));
    expect(find.text('Authentication is required. Status: 401.'), findsOneWidget);
    expect(find.text('Skipped because server reachability did not pass.'), findsOneWidget);
  });

  testWidgets('webdav check page switches to forbidden demo report', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WebDavCheckPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Forbidden'));
    await tester.pumpAndSettle();

    expect(find.text('Server denies access for the current account.'), findsOneWidget);
    expect(find.text('Expected response: 403 Forbidden'), findsOneWidget);
    expect(find.text('Expected outcome: Needs attention'), findsOneWidget);
    expect(find.text('Suggested action: Verify account permissions for the selected WebDAV path.'), findsOneWidget);
    expect(find.textContaining('Some demo checks need attention.'), findsOneWidget);
    expect(find.textContaining('0/2 checks passed'), findsOneWidget);
    expect(find.text('Needs attention'), findsNWidgets(2));
    expect(find.text('Permission denied. Status: 403.'), findsOneWidget);
    expect(find.text('Skipped because server reachability did not pass.'), findsOneWidget);
  });

  testWidgets('webdav check page switches to server error demo report', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WebDavCheckPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Server error'));
    await tester.pumpAndSettle();

    expect(find.text('Server returns a temporary failure.'), findsOneWidget);
    expect(find.text('Expected response: 500 Server error'), findsOneWidget);
    expect(find.text('Expected outcome: Needs attention'), findsOneWidget);
    expect(find.text('Suggested action: Retry later or check the WebDAV server status.'), findsOneWidget);
    expect(find.textContaining('Some demo checks need attention.'), findsOneWidget);
    expect(find.textContaining('0/2 checks passed'), findsOneWidget);
    expect(find.text('Needs attention'), findsNWidgets(2));
    expect(find.text('Network is unavailable. Status: 500.'), findsOneWidget);
    expect(find.text('Skipped because server reachability did not pass.'), findsOneWidget);
  });

  testWidgets('webdav check page switches to missing root demo report', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WebDavCheckPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Missing root'));
    await tester.pumpAndSettle();

    expect(find.text('Server root path cannot be found.'), findsOneWidget);
    expect(find.text('Expected response: 404 Not found'), findsOneWidget);
    expect(find.text('Expected outcome: Needs attention'), findsOneWidget);
    expect(find.text('Suggested action: Check the base URL and remote root path.'), findsOneWidget);
    expect(find.textContaining('Some demo checks need attention.'), findsOneWidget);
    expect(find.textContaining('0/2 checks passed'), findsOneWidget);
    expect(find.text('Needs attention'), findsNWidgets(2));
    expect(find.text('Remote resource was not found. Status: 404.'), findsOneWidget);
    expect(find.text('Skipped because server reachability did not pass.'), findsOneWidget);
  });

  testWidgets('webdav check page refreshes current demo mode', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WebDavCheckPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Missing root'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Refresh check'));
    await tester.pumpAndSettle();

    expect(find.text('Server root path cannot be found.'), findsOneWidget);
    expect(find.text('Expected response: 404 Not found'), findsOneWidget);
    expect(find.text('Expected outcome: Needs attention'), findsOneWidget);
    expect(find.text('Suggested action: Check the base URL and remote root path.'), findsOneWidget);
    expect(find.textContaining('Some demo checks need attention.'), findsOneWidget);
    expect(find.textContaining('0/2 checks passed'), findsOneWidget);
    expect(find.text('Needs attention'), findsNWidgets(2));
    expect(find.text('Remote resource was not found. Status: 404.'), findsOneWidget);
  });
}
