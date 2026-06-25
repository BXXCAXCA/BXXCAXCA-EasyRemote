class RouteEndpoint {
  const RouteEndpoint({
    required this.id,
    required this.displayName,
    required this.source,
    required this.addressLabel,
    required this.isAvailable,
    required this.latencyMs,
    this.userPriority = 100,
  });

  final String id;
  final String displayName;
  final String source;
  final String addressLabel;
  final bool isAvailable;
  final int? latencyMs;
  final int userPriority;

  int get score {
    final latencyScore = latencyMs ?? 9999;
    final availabilityPenalty = isAvailable ? 0 : 100000;
    return availabilityPenalty + latencyScore + userPriority;
  }

  String get latencyLabel {
    if (!isAvailable) return 'unavailable';
    if (latencyMs == null) return 'unknown';
    return '${latencyMs}ms';
  }
}
