# EasyRemote

EasyRemote is a cross-platform authorized device connection and management scaffold.

This repository is prepared for the EasyRemote product plan:

- Windows + Android first.
- Flutter UI shell.
- Local device inventory.
- Route and protocol abstraction.
- Adapter metadata registry.
- WebDAV configuration sync design.
- Sensitive-data vault interface.
- RDP / VNC / SSH / SFTP entry abstractions.
- Future RustDesk research boundary.

> Safety rule: this scaffold does not include a working remote-control engine, credential bypass, stealth access, or hidden control behavior. All future connection behavior must require explicit authorization from the device owner or administrator.

## Quick start

```bash
flutter pub get
flutter run
```

## Repository layout

```text
.
├── assets/adapters/       Adapter metadata examples
├── core/                  Future native core notes
├── docs/                  Product, architecture, security, roadmap
├── lib/                   Flutter app scaffold
├── test/                  Basic tests
└── .github/workflows/     CI placeholder
```

## Current milestone

The current milestone is a safe app skeleton that can be extended into the MVP.
