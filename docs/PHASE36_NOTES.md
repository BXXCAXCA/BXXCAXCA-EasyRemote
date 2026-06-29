# Phase 36 Notes

## Scope

Phase 36 adds a typed list result path for the transport WebDAV client.

## Added

- `WebDavListResult` for list success and mapped failure metadata.
- `TransportWebDavClient.tryList` while keeping `list` compatible.
- Service barrel export coverage for the list result type.
- Focused tests for successful and failed typed list results.

## Local checks

```bash
flutter pub get
flutter analyze
flutter test
```
