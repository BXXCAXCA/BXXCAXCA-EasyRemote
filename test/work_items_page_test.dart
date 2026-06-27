import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/features/work_items/work_items_page.dart';

void main() {
  testWidgets('work items page renders sample planned items', (tester) async {
    await tester.pumpWidget(MaterialApp(home: WorkItemsPage()));

    expect(find.text('Work Items'), findsOneWidget);
    expect(find.text('Work item preview'), findsOneWidget);
    expect(find.text('devices.json'), findsOneWidget);
    expect(find.text('settings.json'), findsOneWidget);
    expect(find.text('manifest.json'), findsOneWidget);
  });
}
