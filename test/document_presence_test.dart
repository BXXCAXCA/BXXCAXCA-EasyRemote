import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('core documents exist', () {
    const paths = [
      'docs/CURRENT_STATUS.md',
      'docs/LOCAL_CHECKS.md',
      'docs/REPOSITORY_INDEX.md',
      'docs/PAGE_INDEX.md',
      'docs/SERVICE_INDEX.md',
      'docs/API_SURFACE.md',
      'docs/DOC_ENTRY.md',
      'docs/BOUNDARY_CHECKLIST.md',
      'docs/RELEASE_PREP.md',
      'docs/ROUTE_SOURCE_USAGE.md',
      'docs/INTERFACE_BASELINE.md',
      'docs/CONTRACT_TESTS.md',
      'docs/IMPLEMENTATION_READINESS.md',
      'docs/VERSION_STATE.md',
      'docs/WEBDAV_IMPLEMENTATION_PLAN.md',
      'docs/STATIC_CLOSEOUT.md',
    ];

    for (final path in paths) {
      expect(File(path).existsSync(), isTrue, reason: path);
    }
  });
}
