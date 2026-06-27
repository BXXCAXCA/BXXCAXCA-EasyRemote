import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/services/sync_plan_service.dart';
import 'package:easyremote/src/services/sync_queue_service.dart';

void main() {
  test('sync plan handles empty maps', () {
    final plan = SyncPlanService().buildPlan(localHashes: {}, remoteHashes: {});
    expect(plan.conflicts, isEmpty);
    expect(plan.uploads, isEmpty);
    expect(plan.downloads, isEmpty);
  });

  test('sync queue handles empty plan items', () {
    final items = SyncQueueService().buildQueue(const []);
    expect(items, isEmpty);
  });
}
