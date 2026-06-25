import '../models/route_endpoint.dart';

class RouteScoreService {
  RouteEndpoint? selectBestRoute(List<RouteEndpoint> routes) {
    final available = routes.where((route) => route.isAvailable).toList();
    if (available.isEmpty) return null;
    available.sort((a, b) => a.score.compareTo(b.score));
    return available.first;
  }
}
