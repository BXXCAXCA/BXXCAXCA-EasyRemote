# Interface Baseline

This document records interfaces that should stay stable before concrete implementations are added.

## Models

- `RouteEndpoint`
- `RouteSourceType`
- `VaultRecord`
- `SyncPlan`
- `SyncConflict`
- `SyncQueueItem`

## Services

- `SyncPlanService.buildPlan`
- `SyncQueueService.buildQueue`
- `HttpTransport.send`
- `WebDavClient`
- `ProductionCryptoAdapter`

## Repositories

- `InventoryRepository`
- `SettingsRepository`
- `VaultRepository`
- `ActivityHistoryRepository`

Before changing these surfaces:

1. Update focused tests.
2. Update docs.
3. Run local checks.
4. Keep existing pages compiling.
