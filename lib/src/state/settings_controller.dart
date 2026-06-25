import 'package:flutter/foundation.dart';
import '../models/app_settings.dart';
import '../repositories/settings_repository.dart';

class SettingsController extends ChangeNotifier {
  SettingsController({required SettingsRepository repository}) : _repository = repository;

  final SettingsRepository _repository;
  AppSettings _settings = AppSettings.defaults();

  AppSettings get settings => _settings;

  Future<void> load() async {
    _settings = await _repository.loadSettings();
    notifyListeners();
  }

  Future<void> update(AppSettings settings) async {
    _settings = settings;
    await _repository.saveSettings(settings);
    notifyListeners();
  }
}
