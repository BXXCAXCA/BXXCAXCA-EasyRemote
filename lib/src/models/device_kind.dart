import 'package:flutter/material.dart';

enum DeviceKind {
  windows('windows'), linux('linux'), nas('nas'), router('router'), mobile('mobile'), generic('generic');
  const DeviceKind(this.id);
  final String id;
  String get label => switch (this) {
    DeviceKind.windows => 'Windows',
    DeviceKind.linux => 'Linux',
    DeviceKind.nas => 'NAS',
    DeviceKind.router => 'Router',
    DeviceKind.mobile => 'Mobile',
    DeviceKind.generic => 'Generic',
  };
  IconData get icon => switch (this) {
    DeviceKind.windows => Icons.desktop_windows_outlined,
    DeviceKind.linux => Icons.dns_outlined,
    DeviceKind.nas => Icons.storage_outlined,
    DeviceKind.router => Icons.router_outlined,
    DeviceKind.mobile => Icons.phone_android_outlined,
    DeviceKind.generic => Icons.devices_other_outlined,
  };
  static DeviceKind fromId(String id) => DeviceKind.values.firstWhere((k) => k.id == id, orElse: () => DeviceKind.generic);
}
