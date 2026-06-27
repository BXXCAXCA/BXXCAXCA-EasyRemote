import '../models/capability_toggle.dart';

class CapabilityToggleService {
  List<CapabilityToggle> list() {
    return const [
      CapabilityToggle(
        id: 'metadata-sync',
        label: 'Metadata sync planning',
        enabled: true,
        notes: 'Planning and validation screens are available.',
      ),
      CapabilityToggle(
        id: 'vault-demo',
        label: 'Vault demo flow',
        enabled: true,
        notes: 'Demo-only codec remains non-production.',
      ),
      CapabilityToggle(
        id: 'native-engine',
        label: 'Native session engine',
        enabled: false,
        notes: 'Not included in this scaffold.',
      ),
    ];
  }
}
