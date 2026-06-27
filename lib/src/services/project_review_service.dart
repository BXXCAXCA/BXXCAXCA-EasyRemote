import '../models/app_settings.dart';
import '../models/project_check_item.dart';

class ProjectReviewService {
  List<ProjectCheckItem> run(AppSettings settings) {
    return [
      const ProjectCheckItem(
        id: 'settings',
        ok: true,
        title: 'Settings model',
        detail: 'Settings object is available.',
      ),
      ProjectCheckItem(
        id: 'confirmation',
        ok: settings.requireEntryConfirmation,
        title: 'Confirmation preference',
        detail: settings.requireEntryConfirmation ? 'Enabled.' : 'Disabled.',
      ),
      ProjectCheckItem(
        id: 'dav-fields',
        ok: !settings.webDavEnabled || settings.webDavUrl.trim().isNotEmpty,
        title: 'DAV fields',
        detail: settings.webDavEnabled ? 'URL should be present.' : 'DAV is off.',
      ),
    ];
  }
}
