# API Surface

## Barrel files

- `lib/src/models/models.dart` exports public model types used across the scaffold.
- `lib/src/services/services.dart` exports planning, review, validation, transport, and boundary services.

## Usage pattern

Feature pages may import focused files directly.

Tests and future integration layers may use barrel files for concise imports.

## Stability note

Barrel exports should only include files that exist in the repository. Add a small compile-oriented test whenever a new barrel file is introduced.
