import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/services/services.dart' as services;

void main() {
  test('service barrel exports WebDAV response parser', () {
    const body = '<d:response><d:href>/dav/file.txt</d:href></d:response>';
    final resources = const services.WebDavResponseParser().parseResources(body);

    expect(resources, hasLength(1));
    expect(resources.first.path, '/dav/file.txt');
  });
}
