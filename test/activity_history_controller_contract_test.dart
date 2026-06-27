import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/repositories/in_memory_activity_history_repository.dart';
import 'package:easyremote/src/state/activity_history_controller.dart';

void main() {
  test('activity history controller adds and clears events', () async {
    final controller = ActivityHistoryController(repository: InMemoryActivityHistoryRepository());

    await controller.load();
    expect(controller.events, isEmpty);

    await controller.add(type: 'note', title: 'Created', description: 'Created for test.');
    expect(controller.events, hasLength(1));

    await controller.clear();
    expect(controller.events, isEmpty);
  });
}
