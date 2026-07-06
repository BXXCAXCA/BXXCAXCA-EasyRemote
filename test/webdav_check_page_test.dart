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

    expect(find.textContaining('Some demo checks need attention.'), findsOneWidget);
    expect(find.textContaining('0/2 checks passed'), findsOneWidget);
    expect(find.text('Needs attention'), findsNWidgets(2));
    expect(find.text('Remote resource was not found. Status: 404.'), findsOneWidget);
  });
}
