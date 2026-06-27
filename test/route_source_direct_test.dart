import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/route_source.dart';

void main() {
  test('route source maps known and unknown ids', () {
    expect(RouteSourceType.fromId('local'), RouteSourceType.local);
    expect(RouteSourceType.fromId('missing'), RouteSourceType.unknown);
  });
}
