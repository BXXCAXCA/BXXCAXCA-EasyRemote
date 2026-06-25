import '../models/managed_device.dart';
import '../models/route_endpoint.dart';

class RouteMergeResult {
  const RouteMergeResult({
    required this.device,
    required this.rankedRoutes,
  });

  final ManagedDevice device;
  final List<RouteEndpoint> rankedRoutes;

  RouteEndpoint? get bestRoute {
    final available = rankedRoutes.where((route) => route.isAvailable).toList();
    if (available.isEmpty) return null;
    return available.first;
  }
}

class RouteMergeService {
  List<RouteMergeResult> buildPlan(List<ManagedDevice> devices) {
    return devices.map((device) {
      final routes = [...device.routes];
      routes.sort((a, b) => a.score.compareTo(b.score));
      return RouteMergeResult(device: device, rankedRoutes: routes);
    }).toList();
  }
}
