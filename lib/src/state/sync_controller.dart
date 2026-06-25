import 'package:flutter/foundation.dart';
import '../models/app_settings.dart';
import '../models/sync_dry_run_result.dart';
import '../services/sync_dry_run_service.dart';

class SyncController extends ChangeNotifier {
  SyncController({SyncDryRunService? service}) : _service = service ?? SyncDryRunService();
  final SyncDryRunService _service;
  SyncDryRunResult? _lastResult;
  bool _running = false;

  SyncDryRunResult? get lastResult => _lastResult;
  bool get running => _running;

  Future<void> runDryRun(AppSettings settings) async {
    _running = true;
    notifyListeners();
    _lastResult = await _service.check(settings);
    _running = false;
    notifyListeners();
  }
}
