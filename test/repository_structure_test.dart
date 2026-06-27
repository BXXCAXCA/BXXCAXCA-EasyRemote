import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('important project folders exist', () {
    expect(Directory('lib/src/features').existsSync(), isTrue);
    expect(Directory('lib/src/models').existsSync(), isTrue);
    expect(Directory('lib/src/services').existsSync(), isTrue);
    expect(Directory('docs').existsSync(), isTrue);
  });
}
