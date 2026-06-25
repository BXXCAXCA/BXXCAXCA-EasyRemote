import 'route_source.dart';

class RouteEndpoint {
  const RouteEndpoint({
    required this.id,
    required this.displayName,
    required this.source,
    required this.sourceType,
    required this.addressLabel,
    required this.isAvailable,
    required this.latencyMs,
    this.userPriority = 100,
    this.successRate = 1.0,
  });

  final String id;
  final String displayName;
  final String source;
  final RouteSourceType sourceType;
  final String addressLabel;
  final bool isAvailable;
  final int? latencyMs;
  final int userPriority;
  final double successRate;

  int get score {
    final latencyScore = latencyMs ?? 9999;
    final availabilityPenalty = isAvailable ? 0 : 100000;
    final reliabilityPenalty = ((1.0 - successRate.clamp(0.0, 1.0)) * 1000).round();
    return availabilityPenalty + latencyScore + userPriority + reliabilityPenalty;
  }

  String get latencyLabel {
    if (!isAvailable) return 'unavailable';
    if (latencyMs == null) return 'unknown';
    return '${latencyMs}ms';
  }

  Map<String, Object?> toJson() => {
    'id': id,
    'displayName': displayName,
    'source': source,
    'sourceType': sourceType.id,
    'addressLabel': addressLabel,
    'isAvailable': isAvailable,
    'latencyMs': latencyMs,
    'userPriority': userPriority,
    'successRate': successRate,
  };

  factory RouteEndpoint.fromJson(Map<String, Object?> json) => RouteEndpoint(
    id: json['id'] as String,
    displayName: json['displayName'] as String,
    source: json['source'] as String,
    sourceType: RouteSourceType.fromId(json['sourceType'] as String? ?? 'unknown'),
    addressLabel: json['addressLabel'] as String,
    isAvailable: json['isAvailable'] as bool,
    latencyMs: json['latencyMs'] as int?,
    userPriority: json['userPriority'] as int? ?? 100,
    successRate: (json['successRate'] as num?)?.toDouble() ?? 1.0,
  );
}
