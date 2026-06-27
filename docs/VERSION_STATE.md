# Version State

Current package metadata:

- `pubspec.yaml`: `0.19.0+19`
- `CHANGELOG.md`: records work through `0.24.0`

Reason:

- Earlier attempts to update package metadata past `0.19.0+19` were blocked by the write guard.
- Changelog entries continue to record completed repository work.

Before tagging or distributing a build:

1. Re-run local checks.
2. Update package metadata locally if needed.
3. Confirm changelog and package metadata are aligned.
4. Commit the version sync from a normal Git client if connector writes remain blocked.
