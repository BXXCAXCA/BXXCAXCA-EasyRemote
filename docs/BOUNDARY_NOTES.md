# Boundary Notes

This project currently focuses on local UI, metadata, validation, planning, and repository structure.

Current boundaries:

- HTTP transport has fake and descriptor-based layers.
- DAV integration has a boundary class and fake client for planning.
- Crypto has a registry and placeholder production boundary.
- Work item pages show planned metadata actions only.
- Import check validates bundle shape.
- Project review summarizes local settings and capabilities.

Before adding concrete external implementations, each boundary should get:

- explicit user-facing confirmation rules,
- test coverage,
- documentation,
- failure handling,
- compatibility notes.
