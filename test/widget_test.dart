import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/main.dart' as app;

void main() {
  testWidgets('app starts', (tester) async {
    app.main();
    await tester.pump();
    expect(find.textContaining('EasyRemote'), findsWidgets);
  });
}
