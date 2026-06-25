import 'package:flutter/material.dart';

import 'connection_protocol.dart';
import 'route_endpoint.dart';

class ManagedDevice {
  const ManagedDevice({
    required this.id,
    required this.name,
    required this.group,
    required this.isOnline,
    required this.icon,
    required this.routes,
    required this.protocols,
  });

  final String id;
  final String name;
  final String group;
  final bool isOnline;
  final IconData icon;
  final List<RouteEndpoint> routes;
  final List<ConnectionProtocol> protocols;

  RouteEndpoint? get bestRoute {
    final available = routes.where((route) => route.isAvailable).toList();
    if (available.isEmpty) return null;
    available.sort((a, b) => a.score.compareTo(b.score));
    return available.first;
  }
}
