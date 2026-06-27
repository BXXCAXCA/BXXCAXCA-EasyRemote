# Service Index

## Planning and review

- `SyncPlanService` builds metadata sync plans.
- `SyncConflictDetector` compares local and remote hashes.
- `SyncQueueService` converts plan items into reviewable work items.
- `ImportCheckService` validates bundle shape.
- `ProjectReviewService` summarizes local project settings.
- `CapabilityToggleService` lists current capability switches.

## Boundaries

- `HttpTransport` defines request/response transport shape.
- `FakeHttpTransport` supports tests.
- `WebDavClient` defines DAV-like storage calls.
- `HttpWebDavClientBoundary` is the future HTTP boundary.
- `ProductionCryptoAdapter` defines future crypto adapter shape.

## Local checks

- `ConfigAuditService` checks local settings.
- `HttpErrorMapper` maps status codes to app error codes.
