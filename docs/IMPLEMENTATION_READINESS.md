# Implementation Readiness

Before replacing placeholders with concrete implementations, confirm these items:

## Local checks

- `flutter pub get`
- `flutter analyze`
- `flutter test`

## Contract coverage

- WebDAV boundary contract test exists.
- Crypto boundary contract test exists.
- HTTP transport contract test exists.
- Repository interface contract test exists.
- Controller contract tests exist for settings, inventory, vault, and activity history.

## Implementation rules

- Add a fake or in-memory path first.
- Keep user-visible status and errors clear.
- Keep secrets out of docs, tests, and sample data.
- Prefer small adapters behind stable interfaces.
- Keep network behavior behind explicit client interfaces.

## Ready candidates

- WebDAV client implementation behind `WebDavClient`.
- Crypto implementation behind `ProductionCryptoAdapter`.
- Import/export validation improvements.
- Controller-driven UI wiring after tests pass locally.
