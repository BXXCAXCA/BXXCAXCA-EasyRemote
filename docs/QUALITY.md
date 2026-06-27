# Quality

This note tracks local quality checks for the EasyRemote scaffold.

## Current focus

- Keep metadata pages renderable with widget tests.
- Keep queue planning deterministic so tests can assert stable item ids.
- Keep HTTP status mapping covered by focused unit tests.
- Keep future platform work behind small adapter boundaries.

## Local commands

Run these after pulling the latest `main` branch:

```bash
flutter pub get
flutter analyze
flutter test
```
