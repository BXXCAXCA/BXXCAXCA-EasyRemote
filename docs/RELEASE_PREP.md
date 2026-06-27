# Release Prep

Before tagging a release:

1. Pull the latest `main` branch.
2. Run local checks.
3. Confirm package version in `pubspec.yaml`.
4. Confirm `CHANGELOG.md` has a matching entry.
5. Confirm core docs exist through `test/document_presence_test.dart`.
6. Confirm barrel exports compile through package surface tests.
7. Confirm constructor-focused tests pass.

Local commands:

```bash
flutter pub get
flutter analyze
flutter test
```

Current note:

- `pubspec.yaml` is currently at `0.19.0+19` because the attempted Phase 20 version bump was blocked.
- Keep `CHANGELOG.md` accurate even when version bumps are delayed.
