import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/activity_event.dart';
import '../repositories/activity_history_repository.dart';

class ActivityHistoryController extends ChangeNotifier {
  ActivityHistoryController({required ActivityHistoryRepository repository}) : _repository = repository;
  final ActivityHistoryRepository _repository;
  List<ActivityEvent> _events = [];
  List<ActivityEvent> get events => List.unmodifiable(_events);

  Future<void> load() async {
    _events = await _repository.loadEvents();
    notifyListeners();
  }

  Future<void> add({
    required String type,
    required String title,
    required String description,
    String? deviceId,
  }) async {
    final event = ActivityEvent(
      id: const Uuid().v4(),
      timestampIso: DateTime.now().toIso8601String(),
      type: type,
      title: title,
      description: description,
      deviceId: deviceId,
    );
    await _repository.append(event);
    await load();
  }

  Future<void> clear() async {
    await _repository.clear();
    await load();
  }
}
