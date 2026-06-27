# WebDAV Implementation Plan

Goal: replace the current boundary placeholder with a concrete client behind `WebDavClient`.

## Scope

- `ping`
- `list`
- `readText`
- `writeText`

## Requirements

- Use `HttpTransport` or another explicit transport boundary.
- Keep credentials outside logs and sample files.
- Return clear errors through mapped app error codes.
- Keep fake transport tests for deterministic checks.
- Add integration tests only when a local test server is available.

## Suggested sequence

1. Add request descriptor builders for DAV operations.
2. Add fake transport contract cases.
3. Add a concrete client class behind `WebDavClient`.
4. Add UI status labels before enabling user-facing actions.
5. Keep placeholder boundary available until local checks pass.

## Non-goals for the first concrete pass

- background sync
- conflict writes
- credential sharing
- hidden operations
