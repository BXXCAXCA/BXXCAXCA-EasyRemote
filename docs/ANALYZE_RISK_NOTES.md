# Analyze Risk Notes

Use this note when reviewing local `flutter analyze` output.

Common areas to inspect:

- barrel files that export missing files,
- widget tests that reference stale constructor parameters,
- package version not matching changelog milestones,
- UI pages that gained new required constructor parameters,
- tests that assert on type literals instead of values,
- files added through small direct commits without a local full test run.

Current mitigation:

- barrel files are covered by package surface tests,
- simple pages have construction tests,
- local check commands are documented in `docs/LOCAL_CHECKS.md`.
