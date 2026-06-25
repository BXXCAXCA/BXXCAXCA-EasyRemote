class ActivityEvent {
  const ActivityEvent({
    required this.id,
    required this.timestampIso,
    required this.type,
    required this.title,
    required this.description,
    this.deviceId,
  });
  final String id;
  final String timestampIso;
  final String type;
  final String title;
  final String description;
  final String? deviceId;
}
