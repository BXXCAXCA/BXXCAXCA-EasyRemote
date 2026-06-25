import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/route_endpoint.dart';
import 'package:easyremote/src/services/route_score_service.dart';

void main() {
  test('selectBestRoute chooses the lowest score available route', () {
    const routes = [
      RouteEndpoint(
        id: 'slow',
        displayName: 'Slow',
        source: 'demo',
        addressLabel: 'a',
        isAvailable: true,
        latencyMs: 80,
      ),
      RouteEndpoint(
        id: 'fast',
        displayName: 'Fast',
        source: 'demo',
        addressLabel: 'b',
        isAvailable: true,
        latencyMs: 10,
      ),
    ];

    final best = RouteScoreService().selectBestRoute(routes);

    expect(best?.id, 'fast');
  });
}
