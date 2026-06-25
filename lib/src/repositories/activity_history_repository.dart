import '../models/activity_event.dart';
abstract class ActivityHistoryRepository {
  Future<List<ActivityEvent>> loadEvents();
  Future<void> append(ActivityEvent event);
  Future<void> clear();
}
