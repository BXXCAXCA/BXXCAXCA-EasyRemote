# Security Model

## Principles

- Only authorized devices are in scope.
- No hidden access behavior.
- No credential bypass.
- Sensitive data must be encrypted before sync or export.
- Connection history and diagnostics must avoid exposing secrets.

## Data classes

| Class | Examples | Handling |
|---|---|---|
| Public metadata | device nickname, group, UI preferences | local storage or sync |
| Protected metadata | addresses, ports, route notes | sync with user awareness |
| Secrets | private keys, tokens, saved passwords | encrypted storage only |

## Future vault design

- Derive a vault key from a user secret or platform keystore.
- Encrypt sensitive fields before persistence.
- Never log raw secrets.
- Support export only with explicit encryption.
