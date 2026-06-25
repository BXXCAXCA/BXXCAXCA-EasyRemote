import 'connection_protocol.dart';
import 'device_kind.dart';
import 'route_endpoint.dart';

class ManagedDevice {
  const ManagedDevice({
    required this.id,
    required this.name,
    required this.group,
    required this.isOnline,
    required this.kind,
    required this.routes,
    required this.protocols,
    this.favorite = false,
    this.tags = const [],
  });

  final String id;
  final String name;
  final String group;
  final bool isOnline;
  final DeviceKind kind;
  final List<RouteEndpoint> routes;
  final List<ConnectionProtocol> protocols;
  final bool favorite;
  final List<String> tags;

  RouteEndpoint? get bestRoute {
    final available = routes.where((route) => route.isAvailable).toList();
    if (available.isEmpty) return null;
    available.sort((a, b) => a.score.compareTo(b.score));
    return available.first;
  }

  ManagedDevice copyWith({bool? favorite}) => ManagedDevice(
    id: id,
    name: name,
    group: group,
    isOnline: isOnline,
    kind: kind,
    routes: routes,
    protocols: protocols,
    favorite: favorite ?? this.favorite,
    tags: tags,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'group': group,
    'isOnline': isOnline,
    'kind': kind.id,
    'routes': routes.map((route) => route.toJson()).toList(),
    'protocols': protocols.map((protocol) => protocol.id).toList(),
    'favorite': favorite,
    'tags': tags,
  };

  factory ManagedDevice.fromJson(Map<String, Object?> json) => ManagedDevice(
    id: json['id'] as String,
    name: json['name'] as String,
    group: json['group'] as String? ?? 'Personal',
    isOnline: json['isOnline'] as bool? ?? false,
    kind: DeviceKind.fromId(json['kind'] as String? ?? 'generic'),
    routes: (json['routes'] as List<Object?>? ?? []).cast<Map<String, Object?>>().map(RouteEndpoint.fromJson).toList(),
    protocols: (json['protocols'] as List<Object?>? ?? []).cast<String>().map(ConnectionProtocol.fromId).toList(),
    favorite: json['favorite'] as bool? ?? false,
    tags: (json['tags'] as List<Object?>? ?? []).cast<String>(),
  );
}
