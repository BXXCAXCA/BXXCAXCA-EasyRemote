import '../models/app_settings.dart';
import 'settings_repository.dart';

class InMemorySettingsRepository implements SettingsRepository {
  AppSettings _settings = AppSettings.defaults();
  @override
  Future<AppSettings> loadSettings() async => _settings;
  @override
  Future<void> saveSettings(AppSettings settings) async => _settings = settings;
}
