import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/sync_queue_item.dart';

void main() {
  test('queue item copy updates status', () {
    const item = SyncQueueItem(
      id: '1',
      path: 'a.json',
      action: SyncQueueAction.validateOnly,
      status: SyncQueueStatus.pending,
    );
    final updated = item.copyWith(status: SyncQueueStatus.completed);
    expect(updated.status, SyncQueueStatus.completed);
    expect(updated.path, item.path);
  });
}
