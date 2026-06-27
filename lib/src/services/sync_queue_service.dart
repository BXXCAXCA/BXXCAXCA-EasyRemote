import '../models/sync_conflict.dart';
import '../models/sync_queue_item.dart';

class SyncQueueService {
  List<SyncQueueItem> buildQueue(List<SyncConflict> conflicts) {
    final items = <SyncQueueItem>[];

    for (final conflict in conflicts) {
      final item = _itemForConflict(conflict);
      if (item != null) {
        items.add(item);
      }
    }

    return items;
  }

  SyncQueueItem? _itemForConflict(SyncConflict conflict) {
    switch (conflict.type) {
      case SyncConflictType.localOnly:
        return _buildItem(
          conflict,
          action: SyncQueueAction.upload,
          status: SyncQueueStatus.pending,
        );
      case SyncConflictType.remoteOnly:
        return _buildItem(
          conflict,
          action: SyncQueueAction.download,
          status: SyncQueueStatus.pending,
        );
      case SyncConflictType.bothChanged:
        return _buildItem(
          conflict,
          action: SyncQueueAction.validateOnly,
          status: SyncQueueStatus.pending,
          errorCode: 'conflictDetected',
        );
      case SyncConflictType.identical:
        return _buildItem(
          conflict,
          action: SyncQueueAction.validateOnly,
          status: SyncQueueStatus.skipped,
        );
    }
  }

  SyncQueueItem _buildItem(
    SyncConflict conflict, {
    required SyncQueueAction action,
    required SyncQueueStatus status,
    String? errorCode,
  }) =>
      SyncQueueItem(
        id: '${action.name}:${conflict.path}',
        path: conflict.path,
        action: action,
        status: status,
        errorCode: errorCode,
      );
}
