# Boundary Checklist

Before adding a concrete adapter behind an interface:

- define the interface in `lib/src/services/`,
- add fake or memory implementation first,
- add focused tests,
- add local error handling,
- add user-visible status labels,
- document configuration fields,
- keep secrets out of shared exports,
- add a page-level review before enabling the path in UI.

Current boundary areas:

- HTTP transport
- DAV storage
- vault codec
- import bundle checks
- work item review
