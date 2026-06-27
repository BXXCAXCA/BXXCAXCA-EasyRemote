import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/route_endpoint.dart';
import 'package:easyremote/src/models/route_source.dart';

void main() {
  test('route endpoint exposes labels and json', () {
    const endpoint = RouteEndpoint(
      id: 'r1',
      displayName: 'LAN',
      source: 'local',
      sourceType: RouteSourceType.local,
      addressLabel: '192.168.x.x',
      isAvailable: true,
      latencyMs: 5,
    );

    expect(endpoint.latencyLabel, '5ms');
    expect(endpoint.toJson()['sourceType'], 'local');
  });

  test('route endpoint handles unavailable route', () {
    const endpoint = RouteEndpoint(
      id: 'r2',
      displayName: 'Offline',
      source: 'manual',
      sourceType: RouteSourceType.manual,
      addressLabel: 'host',
      isAvailable: false,
      latencyMs: null,
    );

    expect(endpoint.latencyLabel, 'unavailable');
  });
}
