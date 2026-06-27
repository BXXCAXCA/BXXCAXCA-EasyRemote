# Phase 27 Notes

Applied directly to main.

Added:

- Demo codec service test.

Fixed:

- Inventory controller test now passes `isOnline` to `ManagedDevice`.
- Model serialization test now passes `isOnline` to `ManagedDevice`.
- Inventory repository boundary test now passes `isOnline` to `ManagedDevice`.

Review focus:

- Keep model constructor tests aligned with model surfaces.
- Prefer small direct fixes when constructor requirements change.
- Run local checks before moving to concrete WebDAV or crypto implementations.
