# Check Naming

Current convention:

- model checks use the model name,
- service checks use the service name or focused behavior,
- smoke checks use `_smoke_test.dart`,
- page construction checks use page-oriented names,
- package surface checks should prefer simple values or instances.

When adding checks:

1. Keep one purpose per file.
2. Keep names stable and searchable.
3. Avoid duplicate file names.
4. Prefer instance-based assertions when possible.
