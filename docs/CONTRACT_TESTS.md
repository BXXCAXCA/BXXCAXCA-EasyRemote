# Contract Tests

Contract tests cover interfaces and placeholder boundaries before concrete implementations are added.

Current contract areas:

- WebDAV boundary
- production crypto boundary
- HTTP transport boundary
- routing models
- repository interfaces and memory implementations
- settings controller behavior

Rules:

1. Keep concrete network behavior outside tests unless a fake transport is used.
2. Keep production crypto placeholders explicit until a reviewed adapter is added.
3. Test constructor surfaces for models used across pages and services.
4. Add docs before replacing a placeholder with a concrete implementation.
5. Keep controller tests focused on repository interaction and state changes.

Local command:

```bash
flutter test
```
