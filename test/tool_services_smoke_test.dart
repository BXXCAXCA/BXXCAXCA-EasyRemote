import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_settings.dart';
import 'package:easyremote/src/services/capability_toggle_service.dart';
import 'package:easyremote/src/services/project_review_service.dart';

void main() {
  test('tool services return review data', () {
    expect(CapabilityToggleService().list(), isNotEmpty);
    expect(ProjectReviewService().run(AppSettings.defaults()), isNotEmpty);
  });
}
