# Phase 38 Notes

## Scope

Phase 38 adds a WebDAV check service that prepares status items for UI display.

## Added

- `WebDavCheckItem` and `WebDavCheckReport`.
- `WebDavCheckService` that checks reachability first and then directory listing.
- Service barrel exports for the new check service and report.
- Focused tests for success and skipped listing after a failed reachability check.

## Local checks

```bash
flutter pub get
flutter analyze
flutter test
```
