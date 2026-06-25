import '../models/activity_event.dart';
import 'activity_history_repository.dart';

class InMemoryActivityHistoryRepository implements ActivityHistoryRepository {
  final List<ActivityEvent> _events = [];
  @override
  Future<List<ActivityEvent>> loadEvents() async => List.unmodifiable(_events.reversed);
  @override
  Future<void> append(ActivityEvent event) async => _events.add(event);
  @override
  Future<void> clear() async => _events.clear();
}
