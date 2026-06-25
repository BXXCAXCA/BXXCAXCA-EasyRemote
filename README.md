# EasyRemote

EasyRemote is a cross-platform authorized device connection and management scaffold.

## Phase 6

This package adds the next safe development layer:

- Vault crypto interface and demo-only codec.
- Platform keystore interface.
- Vault record model and repository abstraction.
- WebDAV settings form.
- Sync dry-run service and page.
- Backup preview service and page.
- Metadata-only backup bundle.
- Tests for vault, sync dry-run, and backup service.

This scaffold does not include a working remote-control engine, credential bypass, stealth access, or hidden control behavior.

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```
