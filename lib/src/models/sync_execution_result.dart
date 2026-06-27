import 'app_error_code.dart';
import 'sync_queue_item.dart';

class SyncExecutionResult {
  const SyncExecutionResult({
    required this.item,
    required this.success,
    required this.startedAtIso,
    required this.finishedAtIso,
    this.errorCode,
    this.detail,
  });

  final SyncQueueItem item;
  final bool success;
  final String startedAtIso;
  final String finishedAtIso;
  final AppErrorCode? errorCode;
  final String? detail;
}
