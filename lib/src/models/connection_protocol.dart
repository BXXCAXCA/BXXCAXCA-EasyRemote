import 'package:flutter/material.dart';

enum ConnectionProtocol {
  desktop('desktop'), screen('screen'), shell('shell'), files('files'), nativeSession('native');
  const ConnectionProtocol(this.id);
  final String id;
  String get label => switch (this) {
    ConnectionProtocol.desktop => 'Desktop',
    ConnectionProtocol.screen => 'Screen',
    ConnectionProtocol.shell => 'Shell',
    ConnectionProtocol.files => 'Files',
    ConnectionProtocol.nativeSession => 'Native',
  };
  IconData get icon => switch (this) {
    ConnectionProtocol.desktop => Icons.desktop_windows_outlined,
    ConnectionProtocol.screen => Icons.fit_screen_outlined,
    ConnectionProtocol.shell => Icons.terminal_outlined,
    ConnectionProtocol.files => Icons.folder_outlined,
    ConnectionProtocol.nativeSession => Icons.touch_app_outlined,
  };
  static ConnectionProtocol fromId(String id) => ConnectionProtocol.values.firstWhere((p) => p.id == id, orElse: () => ConnectionProtocol.desktop);
}
