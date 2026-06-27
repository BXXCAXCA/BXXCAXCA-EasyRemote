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
    ];

    for (final path in paths) {
      expect(File(path).existsSync(), isTrue, reason: path);
    }
  });
}
