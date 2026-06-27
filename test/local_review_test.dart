import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_settings.dart';
import 'package:easyremote/src/services/project_review_service.dart';

void main() {
  test('local review returns items', () {
    final items = ProjectReviewService().run(AppSettings.defaults());
    expect(items.length, greaterThan(0));
  });
}
