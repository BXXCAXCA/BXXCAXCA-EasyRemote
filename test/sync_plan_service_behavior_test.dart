import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/sync_conflict.dart';
import 'package:easyremote/src/services/sync_plan_service.dart';

void main() {
  test('sync plan detects upload and download paths', () {
    final plan = SyncPlanService().buildPlan(
      localHashes: {'local.json': 'a'},
      remoteHashes: {'remote.json': 'b'},
    );

    expect(plan.uploads, contains('local.json'));
    expect(plan.downloads, contains('remote.json'));
  });

  test('sync plan detects user decision conflict', () {
    final plan = SyncPlanService().buildPlan(
      localHashes: {'shared.json': 'a'},
      remoteHashes: {'shared.json': 'b'},
    );

    expect(plan.conflicts.any((item) => item.type == SyncConflictType.bothChanged), isTrue);
    expect(plan.requiresUserDecision, isTrue);
  });
}
