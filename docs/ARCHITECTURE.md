# Architecture

## Layers

```text
Flutter UI
  -> Application services
  -> Domain models
  -> Platform gateway interfaces
  -> Future native core
```

## UI

Flutter is used for the app shell because the first target is Windows plus Android, with later expansion to Linux, iOS, and HarmonyOS.

## Domain

Core domain objects:

- ManagedDevice
- RouteEndpoint
- ConnectionProtocol
- IntegrationAdapter

## Services

Initial placeholder services:

- MockInventoryService
- RouteScoreService
- ProtocolGateway
- VaultService
- SyncService

## Native boundary

Future native modules should run behind clear interfaces and should be auditable, permission-aware, and license-compliant.
