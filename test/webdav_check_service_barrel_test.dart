import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/services/services.dart' as services;

void main() {
  test('service barrel exports WebDAV check report', () {
    const report = services.WebDavCheckReport(items: []);
    expect(report.ok, isTrue);
  });

  test('service barrel exports WebDAV check demo service', () {
    expect(services.WebDavCheckDemoMode.success.label, 'Success');
    expect(const services.WebDavCheckDemoService(), isA<services.WebDavCheckDemoService>());
  });
}
