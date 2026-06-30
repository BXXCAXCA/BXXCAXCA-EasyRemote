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
    expect(find.textContaining('2/2 checks passed'), findsOneWidget);
    expect(find.textContaining('Last checked:'), findsOneWidget);
    expect(find.text('Server reachability'), findsOneWidget);
    expect(find.text('Directory listing'), findsOneWidget);
    expect(find.textContaining('All demo checks passed.'), findsOneWidget);
  });

  testWidgets('webdav check page switches to missing root demo report', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WebDavCheckPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Missing root'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Some demo checks need attention.'), findsOneWidget);
    expect(find.textContaining('0/2 checks passed'), findsOneWidget);
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
    expect(find.text('Remote resource was not found. Status: 404.'), findsOneWidget);
  });
}
