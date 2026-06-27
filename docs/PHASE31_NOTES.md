# Phase 31 Notes

Applied directly to main.

Added:

- `TransportWebDavClient`
- transport WebDAV client tests
- service barrel export for the transport client
- service barrel test for the transport client

Scope:

- uses injected `HttpTransport`
- tests use `FakeHttpTransport`
- no direct socket or platform network code
- no credential handling
- list parsing is intentionally deferred

Next candidate:

- add small response parsers for DAV-style metadata using fixture strings.
