enum RouteSourceType {
  local('local'), manual('manual'), mesh('mesh'), tunnel('tunnel'), relay('relay'), history('history'), unknown('unknown');
  const RouteSourceType(this.id);
  final String id;
  String get label => switch (this) {
    RouteSourceType.local => 'Local',
    RouteSourceType.manual => 'Manual',
    RouteSourceType.mesh => 'Mesh',
    RouteSourceType.tunnel => 'Tunnel',
    RouteSourceType.relay => 'Relay',
    RouteSourceType.history => 'History',
    RouteSourceType.unknown => 'Unknown',
  };
  static RouteSourceType fromId(String id) => RouteSourceType.values.firstWhere((v) => v.id == id, orElse: () => RouteSourceType.unknown);
}
