import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/features/webdav_check/webdav_check_page.dart';

void main() {
  testWidgets('webdav check page renders demo report', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WebDavCheckPage()));
    await tester.pumpAndSettle();

    expect(find.text('WebDAV Check'), findsOneWidget);
    expect(find.text('WebDAV check preview'), findsOneWidget);
    expect(find.text('Server reachability'), findsOneWidget);
    expect(find.text('Directory listing'), findsOneWidget);
    expect(find.text('All demo checks passed.'), findsOneWidget);
  });
}
