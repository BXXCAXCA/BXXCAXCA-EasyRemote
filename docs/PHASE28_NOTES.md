# Phase 28 Notes

Applied directly to main.

Checked:

- page construction test
- tools page widget test
- routing models barrel test
- package surface test
- barrel exports test

Fixed:

- Replaced the conflict page segmented marker with a simple review chip.
- Added conflict page construction coverage.

Confirmed:

- `CapabilityToggleService.list()` exists.
- `CryptoAdapterRegistry.availableAdapters()` exists.
- `routing_models.dart` exports route endpoint and route source types.

Local checks still required:

```bash
flutter analyze
flutter test
```
