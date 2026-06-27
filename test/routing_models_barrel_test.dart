import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/routing_models.dart';

void main() {
  test('routing barrel exports route endpoint and source type', () {
    const endpoint = RouteEndpoint(
      id: 'r1',
      displayName: 'LAN',
      source: 'local',
      sourceType: RouteSourceType.local,
      addressLabel: '192.168.x.x',
      isAvailable: true,
      latencyMs: 10,
    );

    expect(endpoint.sourceType, RouteSourceType.local);
    expect(RouteSourceType.fromId('local'), RouteSourceType.local);
  });
}
