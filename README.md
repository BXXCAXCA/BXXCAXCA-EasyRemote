# EasyRemote

EasyRemote is a cross-platform authorized device connection and management scaffold.

## Current phase

Phase 9 has been applied directly to `main`.

Highlights:

- Phase 8 infrastructure boundaries are complete.
- App error code model.
- HTTP request and response descriptor model.
- HTTP transport interface and fake transport.
- Sync queue item model and queue service.
- Import check model and service.
- Conflict resolution page scaffold.
- Import check page scaffold.
- Phase 9 docs and tests.

See `docs/PHASE8_STATUS.md` and `docs/PHASE9_STATUS.md` for completion notes.

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```
