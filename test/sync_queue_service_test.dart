import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/sync_conflict.dart';
import 'package:easyremote/src/models/sync_queue_item.dart';
import 'package:easyremote/src/services/sync_queue_service.dart';

void main() {
  test('queue maps local only to upload', () {
    final queue = SyncQueueService().buildQueue(const [
      SyncConflict(
        path: 'a',
        type: SyncConflictType.localOnly,
        localHash: '1',
        remoteHash: null,
      ),
    ]);

    expect(queue.single.action, SyncQueueAction.upload);
    expect(queue.single.status, SyncQueueStatus.pending);
    expect(queue.single.id, 'upload:a');
  });

  test('queue maps remote only to download', () {
    final queue = SyncQueueService().buildQueue(const [
      SyncConflict(
        path: 'b',
        type: SyncConflictType.remoteOnly,
        localHash: null,
        remoteHash: '2',
      ),
    ]);

    expect(queue.single.action, SyncQueueAction.download);
    expect(queue.single.status, SyncQueueStatus.pending);
    expect(queue.single.id, 'download:b');
  });

  test('queue keeps both changed items in review state', () {
    final queue = SyncQueueService().buildQueue(const [
      SyncConflict(
        path: 'c',
        type: SyncConflictType.bothChanged,
        localHash: 'local',
        remoteHash: 'remote',
      ),
    ]);

    expect(queue.single.action, SyncQueueAction.validateOnly);
    expect(queue.single.status, SyncQueueStatus.pending);
    expect(queue.single.errorCode, 'conflictDetected');
    expect(queue.single.id, 'validateOnly:c');
  });

  test('queue skips identical items', () {
    final queue = SyncQueueService().buildQueue(const [
      SyncConflict(
        path: 'd',
        type: SyncConflictType.identical,
        localHash: 'same',
        remoteHash: 'same',
      ),
    ]);

    expect(queue.single.action, SyncQueueAction.validateOnly);
    expect(queue.single.status, SyncQueueStatus.skipped);
    expect(queue.single.id, 'validateOnly:d');
  });
}
